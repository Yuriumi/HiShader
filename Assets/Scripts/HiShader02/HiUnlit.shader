// Shader ��·������  Ĭ��Ϊ�ļ���,Ҳ�������ļ�����ͬ
Shader "Unlit/HiShader"
{
    // ���� 
    // Material Inspector��ʾ�����в���������Ҫ�������������
    Properties
    {
        // ͨ�����������������»����ַ���ͷ _MainTex
        _MainTex ("Texture", 2D) = "white" {}
        
        // �Ƚϳ�������������
        // ������������������������������������������������������������������������������������������������
        _Integer ("����(�°�)", Integer) = 1
        _Int ("����(�ɰ�)", Int) = 1
        _Float ("������", Float) = 0.5
        _FloatRange ("������������", Range(0.0, 1.0)) = 0.5
        // Unity����������������, ����ֱ�����
        // ��white����RGBA��1,1,1,1��
        // ��black����RGBA��0,0,0,1��
        // ��gray����RGBA��0.5,0.5,0.5,1��
        // ��bump����RGBA��0.5,0.5,1,0.5��
        // ��red����RGBA��1,0,0,1��
        _Texture2D ("2D������ͼ", 2D) = "red" {}
        // �ַ������ջ�������Чֵ������Ĭ��Ϊ ��gray��
        _DefaultTexture2D ("2D������ͼ", 2D) = "" {}
        // Ĭ��ֵΪ ��gray����RGBA��0.5,0.5,0.5,1��
        _Texture3D ("3D������ͼ", 3D) = "" {}
        _Cubemap ("��������ͼ", Cube) = "" {}
        // Inspector����ʾ�ĸ������ĸ������ֶ�
        _Vector ("Example vector", Vector) = (0.25, 0.5, 0.5, 1)
        // Inspector����ʾʰɫ��ʰȡɫ��RGBAֵ
        _Color("ɫ��", Color) = (0.25, 0.5, 0.5, 1)
        // ������������������������������������������������������������������������������������������������
        
        // ����֮�� �������������Ծ���һ����ѡ���� ������֪Unity��δ�������
        // HDR����ʹɫ�����ȵ�ֵ����1
        [HDR]_HDRColor("HDRɫ��", Color) = (1,1,1,1)
        // Inspector���ش�����
        [HideInInspector]_Hide("��������~", Color) = (1,1,1,1)
        // Inspector���ش��������Ե�Scale Offset�ֶ�
        [NoScaleOffset]_HideScaleOffset("����ScaleOffset", 2D) = "" {}
        // ָʾ��������Ϊ������ͼ����������˲����ݵ������༭�������ʾ���档
        [Normal]_Normal("������ͼ", 2D) = "" {}
    }
    
    // ����ɫ�� 
    // һ��Shader������һ�����߶������ɫ��SubShader����Щ����ɫ���������ţ���ֻ��һ��������
    // �ڼ���shaderʱUnity���������SubShader�б�������ѡ���û�����֧�ֵĵ�һ��
    SubShader
    {
        // ����ͨ��Tags��������ɫ�������ǩ
        // ֻ����д��SubShader�����,����д��Pass��
        /* �Լ�ֵ�Ե���ʽ����,���Գ��ֶ����ֵ��
        Tags { 
            "TagName1" = "Value1"
            "TagName2" = "Value2"
            "TagName3" = "Value3"
            ...
            }
        */
        
        // RenderPipeline: ��������ɫ���Ƿ���ͨ����Ⱦ���� (URP) �������Ⱦ���� (HDRP) ����
        // ���� URP ����
        // Tags { "RenderPipeline"="UniversalRenderPipeline" }
        // ���� HDRP ����
        // Tags { "RenderPipeline"="HighDefinitionRenderPipeline" }
        // RenderPipeline���������κ�����ֵ��ʾ�� URP �� HDRP ������
        // ������������������������������������������������������������������������������������������������
        
        // Queue: ������Ⱦ����
        // Tags { "Queue"="Background" } // ���类���õ���Ⱦ��������Ⱦ��պл��߱���
        // Tags { "Queue"="Geometry" }   // ����Ĭ��ֵ��������Ⱦ��͸�����壨��ͨ����£������еľ����������Ӧ���Ƿ�͸���ģ�
        // Tags { "Queue"="AlphaTest" }  // ������Ⱦ����Alpha Test�����أ�����ΪAlphaTest�趨һ��Queue�ǳ��ڶ�Ч�ʵĿ���
        // Tags { "Queue"="Transparent" }// �ԴӺ���ǰ��˳����Ⱦ͸������
        // Tags { "Queue"="Overlay" }    // ������Ⱦ���ӵ�Ч��������Ⱦ�����׶Σ����羵ͷ���ε���Ч��
        // ������������������������������������������������������������������������������������������������
        
        // RenderType: �����������ShaderҪ��Ⱦ�Ķ���������ʲô���ġ�
        // ������Ⱦ���� ��һ�ֳ�Ϊ��ɫ���滻�ļ���������ʱ��������ɫ��,�����������ShaderҪ��Ⱦ�Ķ���������ʲô����
        // �����ʾ��͸��������Ⱦ
        Tags { "RenderType"="Opaque" }
        // ������ϸ���ݿɲο������ĵ� https://docs.unity.cn/cn/2021.3/Manual/SL-SubShaderTags.html
        
        // LOD (Level of Detail)
        LOD 100

        // ÿ������ɫ���ɶ��ͨ����ɣ����򵥵���ɫ��ֻʹ��һ��ͨ��������ҪһЩ�����ӵ�Ч������ɫ��������Ҫ����ͨ��
        // һ��Pass����һ�λ��ƣ����Կ�����һ��Draw Call��Pass���������ڶ����Ⱦ��
        // �������һ��Pass����ô��ɫ��ֻ�ᱻ����һ�Σ�������ж��Pass�Ļ���
        // ��ô���൱��ִ�ж��SubShader�ˣ���ͽ�˫ͨ�����߶�ͨ����
        
        // Draw Call����ʵ����CPU����ͼ���̽ӿڵ���Ⱦ���CPUÿ�ε���DrawCall������Ҫ��GPU����������ݰ�����Ⱦ״̬�ȵȣ�
        // һ��CPUִ����Ӧ�ý׶Σ�GPU�ͻῪʼִ����ε���Ⱦ���̡���GPU��Ⱦ���ٶȱ�CPU�ύ������ٶ�Ҫ��Ķ࣬
        // �������DrawCall�������������£�CPU��Ҫ���д����ļ��㣬�����ͻᵼ��CPU���أ�Ӱ����Ϸ������Ч�ʡ�
        Pass
        {
            CGPROGRAM
            // ����������ɫ��
            #pragma vertex vert
            // ����������ɫ��
            #pragma fragment frag
            // ʹ����Ч
            #pragma multi_compile_fog

            // ����CG�ĺ��Ĵ����
            #include "UnityCG.cginc"

            // Ӧ�ó���׶νṹ��
            struct appdata
            {
                // �ο���https://docs.microsoft.com/zh-cn/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics
                // POSITION ��ɫ�����Ե����壬�����޶���ɫ�����������ֵ������
                // ģ�Ϳռ�Ķ�������
                float4 vertex : POSITION;
                // ģ�͵ĵ�һ��UV����
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                // UV
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                // SV_POSITION �����ֵ��Ҫ��Ϊ���ֵ�����ϵͳ�õ�ʱ�� ǰ����Ҫ��SV_ǰ׺
                // ��Ȼ��Ϊ�����¼��ݵĻ��� ����Ҳûɶ̫������
                float4 vertex : SV_POSITION;
            };

            // ��Properties�������Ĳ���Ҫ���������Ӧ�Ķ����ſ���ʹ��
            sampler2D _MainTex;
            float4 _MainTex_ST;

            // ���嶥����ɫ������ ������Ҫ������������ɫ��������ͬ
            v2f vert (appdata v)
            {
                v2f o;
                // �����������ģ�Ϳռ�任���ü��ռ�
                o.vertex = UnityObjectToClipPos(v.vertex);
                // Transforms 2D UV by scale/bias property
                // #define TRANSFORM_TEX(tex,name) (tex.xy * name##_ST.xy + name##_ST.zw)
                // �ȼ���v.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                // ����˵��TRANSFORM_TEX��Ҫ�������ö����uvȥ�Ͳ������tiling��offset�����㣬
                // ȷ��������������ź�ƫ����������ȷ��
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            // SV_Target������ΪCOLOR ����˵��Ҳ����Ϊ���ֵ�����ϵͳ��
            // ������ʵ�Ǹ���ϵͳ���������ɫֵ�洢��RenderTarget��
            // ��������������SV_Target
            fixed4 frag (v2f i) : SV_Target
            {
                // ����2D������ͼ
                fixed4 col = tex2D(_MainTex, i.uv);
                // Ӧ����
                UNITY_APPLY_FOG(i.fogCoord, col);
                // ���ؾ�������������ɫ��
                return col;
            }
            ENDCG
        }
    }
}