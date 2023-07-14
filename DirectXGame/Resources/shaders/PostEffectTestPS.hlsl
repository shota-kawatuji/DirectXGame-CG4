#include "PostEffectTest.hlsli"

Texture2D<float4> tex0 : register(t0);  // 0番スロットに設定されたテクスチャ
Texture2D<float4> tex1 : register(t1);  // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);        // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
    float4 colortex0 = tex0.Sample(smp, input.uv);
    float4 colortex1 = tex1.Sample(smp, input.uv);

    // 平均ぼかしを加える
    float4 blur = 0.0f;
    float2 texelSize = 1.0f / float2(256, 256); // テクセルサイズを計算
    for (int i = -1; i <= 1; ++i) {
        for (int j = -1; j <= 1; ++j) {
            blur += tex1.Sample(smp, input.uv + float2(texelSize.x * i, texelSize.y * j));
        }
    }
    colortex1 = blur / 9.0f;

    float4 color = 1 - colortex0;
    if (fmod(input.uv.y, 0.1f) < 0.05f) {
        color = lerp(colortex0, colortex1, 0.4f);
    }

    return float4(color.rgb, 1);
}
