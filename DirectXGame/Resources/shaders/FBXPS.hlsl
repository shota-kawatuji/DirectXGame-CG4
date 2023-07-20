#include "FBX.hlsli"

Texture2D<float4> tex : register(t0);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);        // 0番スロットに設定されたサンプラー

struct PSOutput
{
	float4 target0 : SV_TARGET0;
	float4 target1 : SV_TARGET1;
};

// エントリーポイント
PSOutput main(VSOutput input)
{
	PSOutput output;
	// テクスチャマッピング
	float4 texcolor0 = tex.Sample(smp, input.uv);
	float4 texcolor1 = tex.Sample(smp, input.uv);
	// Lambert反射
	float3 light = normalize(float3(1, -1, 1)); // 右下奥 向きのライト
	float diffuse = saturate(dot(-light, input.normal));
	float brightness = diffuse + 0.3f;
	float4 shadecolor = float4(brightness, brightness, brightness, 1.0f);

	float window_width = 1280;
	float window_height = 720;
	// 平均ぼかし
	float4 blur = 0; // 合計色
	float2 texSize = float2(1.0f / window_width, 1.0f / window_height);
	for (int i = -3; i <= 3; i++) {
		for (int j = -3; j <= 3; j++) {
			blur += tex.Sample(smp, input.uv + float2(i, j) * texSize);
		}
	}
	texcolor1 = blur / 49;

	// 陰影とテクスチャの色を合成
	output.target0 = shadecolor * float4(texcolor0.rgb, 1);
	output.target1 = shadecolor * texcolor1;
	return output;
}
