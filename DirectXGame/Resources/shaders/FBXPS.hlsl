#include "FBX.hlsli"
// 0�ԃX���b�g�ɐݒ肳�ꂽ�e�N�X�`��
Texture2D<float4> tex : register(t0);
// 0�ԃX���b�g�ɐݒ肳�ꂽ�T���v���[
SamplerState smp : register(s0);
// ��
static const float PI = 3.141592654f;
// ���˓_�̖@���x�N�g��
static float3 N;

// �o�������˕��z�֐�
float3 BRDF(float3 L, float3 V)
{
	// �@���ƃ��C�g�����̓���
	float NdotL = dot(N, L);
	// �@���ƃJ���������̓���
	float NdotV = dot(N, V);
	// �ǂ��炩��90�x�ȏ�ł���ΐ^������Ԃ�
	if (NdotL < 0 || NdotV < 0) { return float3(0, 0, 0); }

	// �g�U���˗�
	float diffuseReflectance = 1.0f / PI;
	// �������ˍ�
	float3 diffuseColor = diffuseReflectance * NdotL * baseColor * (1 - metalness);

	//�����ɋ��ʔ��˂̎���}������

	return diffuseColor;
}

// �G���g���[�|�C���g
float4 main(VSOutput input) : SV_TARGET
{
	// �ʂ̏���static�ϐ��ɑ�����A�֐�����Q�Ƃł���悤�ɂ���
	N = input.normal;
	// �ŏI�I��RGB
	float3 finalRGB = float3(0,0,0);
	// ���_���王�_�ւ̕����x�N�g��
	float3 eyedir = normalize(cameraPos - input.worldpos.xyz);
	
	// ���s����
	for (int i = 0; i < DIRLIGHT_NUM; i++) {
		if (!dirLights[i].active) {
			continue;
		}
		// BRDF�̌��ʂƃ��C�g�F������
		finalRGB += BRDF(dirLights[i].lightv, eyedir) * dirLights[i].lightcolor;
	}
	
	return float4(finalRGB, 1);
}