#include "FBX.hlsli"

Texture2D<float4> tex : register(t0);  // 0�ԃX���b�g�ɐݒ肳�ꂽ�e�N�X�`��
SamplerState smp : register(s0);        // 0�ԃX���b�g�ɐݒ肳�ꂽ�T���v���[

struct PSOutput
{
	float4 target0 : SV_TARGET0;
	float4 target1 : SV_TARGET1;
};

// �G���g���[�|�C���g
PSOutput main(VSOutput input)
{
	PSOutput output;
	// �e�N�X�`���}�b�s���O
	float4 texcolor0 = tex.Sample(smp, input.uv);
	float4 texcolor1 = tex.Sample(smp, input.uv);
	// Lambert����
	float3 light = normalize(float3(1, -1, 1)); // �E���� �����̃��C�g
	float diffuse = saturate(dot(-light, input.normal));
	float brightness = diffuse + 0.3f;
	float4 shadecolor = float4(brightness, brightness, brightness, 1.0f);

	float window_width = 1280;
	float window_height = 720;
	// ���ςڂ���
	float4 blur = 0; // ���v�F
	float2 texSize = float2(1.0f / window_width, 1.0f / window_height);
	for (int i = -3; i <= 3; i++) {
		for (int j = -3; j <= 3; j++) {
			blur += tex.Sample(smp, input.uv + float2(i, j) * texSize);
		}
	}
	texcolor1 = blur / 49;

	// �A�e�ƃe�N�X�`���̐F������
	output.target0 = shadecolor * float4(texcolor0.rgb, 1);
	output.target1 = shadecolor * texcolor1;
	return output;
}
