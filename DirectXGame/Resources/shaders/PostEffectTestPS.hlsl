#include "PostEffectTest.hlsli"

Texture2D<float4> tex : register(t0);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);      // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
	//float4 texcolor = tex.Sample(smp, input.uv + float2(0.5f, 0)); // UVずらし
	//return float4(texcolor.rgb * 3.0f, 1); // 明度変更
	//return float4(1 - texcolor.rgb, 1); // 色の反転

	float4 texcolor = 0;
	float2 texelSize = 1.0 / float2(256, 256); // テクセルサイズを計算する
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
			float2 offset = float2(x, y) * texelSize;
			texcolor += tex.Sample(smp, input.uv + offset);
		}
	}
	texcolor /= 9.0; // 9で割ることで平均値を求める

	return float4(texcolor.rgb, 1);
}
