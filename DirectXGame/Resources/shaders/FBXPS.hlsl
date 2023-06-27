#include "FBX.hlsli"
// 0番スロットに設定されたテクスチャ
Texture2D<float4> tex : register(t0);
// 0番スロットに設定されたサンプラー
SamplerState smp : register(s0);
// エントリーポイント
float4 main(VSOutput input) : SV_TARGET
{
	// ライトのアンビエントカラーをRGBとして塗る
	return float4(ambientLightColor,1);
}
