Shader "Custom/Retro"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Color", Color) = (0.3, 1, 0.3, 1)
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 scr_pos : TEXCOORD1;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.scr_pos = ComputeScreenPos(v.vertex);
				return o;
			}
			
			sampler2D _MainTex;
			uniform fixed4 _Color;
			uniform float _ColorSteps;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed greyscale = (col.r + col.g + col.b)/3;
				greyscale = round(greyscale*_ColorSteps)/_ColorSteps;

				float2 ps = i.scr_pos.xy *_ScreenParams.xy / i.scr_pos.w;
				ps.x = round(ps.x);
				ps.y = round(ps.y);

				fixed val = 0;
				if (greyscale >= 0.8f) {
					val = 1;
				}
				else
				if (greyscale >= 0.6f) {
					if (ps.x % 4 != 0) {
						val = 1;
					}
				}
				else
				if (greyscale >= 0.4f) {
					if (ps.x % 2 == 0) {
						val = 1;
					}
				}
				else
				if (greyscale >= 0.2f) {
					if (ps.x % 4 == 0) {
						val = 1;
					}
					if (ps.y % 2 == 0) {
						val = 0;
					}
				}

				return val * _Color;
			}
			ENDCG
		}
	}
}
