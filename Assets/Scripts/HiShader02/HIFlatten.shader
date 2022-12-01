Shader "Unlit/HIFlatten"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Value ("ѹ��ϵ��",Range(0, 1)) = 0
        _Bottom ("�ײ�", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Value;
            float _Bottom;

            v2f vert (appdata v)
            {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // ģ�Ϳռ�ת������ռ�
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                // ѹY��λ�� ���������ռ��¶����y��ȥ��Ͳ�y��ֵ����һ��ϵ��
                // Ȼ������yȥ��ȥ���ֵ���Ϳ���ͨ�����ϵ�����������ӱ�ѹ��ĳ̶�
                float y = worldPos.y - (worldPos.y - _Bottom) * _Value;
                // ��������ռ�λ��
                float3 tempWorld = float3(worldPos.x,y,worldPos.z);
                // ����ռ�ת�ü��ռ�
                o.vertex = UnityWorldToClipPos(tempWorld);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
