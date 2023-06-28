#include "FBX.hlsli"
// 0番スロットに設定されたテクスチャ
Texture2D<float4> tex : register(t0);
// 0番スロットに設定されたサンプラー
SamplerState smp : register(s0);
// π
static const float PI = 3.141592654f;
// 反射点の法線ベクトル
static float3 N;

// 双方向反射分布関数
float3 BRDF(float3 L, float3 V)
{
	// 法線とライト方向の内積
	float NdotL = dot(N, L);
	// 法線とカメラ方向の内積
	float NdotV = dot(N, V);
	// どちらかが90度以上であれば真っ黒を返す
	if (NdotL < 0 || NdotV < 0) { return float3(0, 0, 0); }

	// 拡散反射率
	float diffuseReflectance = 1.0f / PI;
	// 初期反射項
	float3 diffuseColor = diffuseReflectance * NdotL * baseColor * (1 - metalness);

	//ここに鏡面反射の式を挿入する

	return diffuseColor;
}

// エントリーポイント
float4 main(VSOutput input) : SV_TARGET
{
	// 面の情報をstatic変数に代入し、関数から参照できるようにする
	N = input.normal;
	// 最終的なRGB
	float3 finalRGB = float3(0,0,0);
	// 頂点から視点への方向ベクトル
	float3 eyedir = normalize(cameraPos - input.worldpos.xyz);
	
	// 平行光源
	for (int i = 0; i < DIRLIGHT_NUM; i++) {
		if (!dirLights[i].active) {
			continue;
		}
		// BRDFの結果とライト色を合成
		finalRGB += BRDF(dirLights[i].lightv, eyedir) * dirLights[i].lightcolor;
	}
	
	return float4(finalRGB, 1);
}