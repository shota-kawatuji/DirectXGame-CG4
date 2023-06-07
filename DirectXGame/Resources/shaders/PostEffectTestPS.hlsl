#include "PostEffectTest.hlsli"

Texture2D<float4> tex : register(t0);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);      // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
	//float4 texcolor = tex.Sample(smp,input.uv + 0.5f); // UVずらし
	//return float4(texcolor.rgb * 3.0f, 1); // 明度変更
	//return float4(1 - texcolor.rgb, 1); // 色の反転
	//float4 texcolor = tex.Sample(smp,input.uv);
	//return float4(texcolor.rgb, 1);

	float window_Width = 1280;
	float window_Height = 720;
	// U座標の変化量の計算
	float Upixel = 1 / window_Width;
	// V座標の変化量の計算
	float Vpixel = 1 / window_Height;
	// 色の合計
	float col = { 0,0,0,0 };

	col = 

	col.rgb = col.rgb / 9;
	col.a = 1;
	return col;
}
