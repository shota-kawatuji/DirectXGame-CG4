#include "FBX.hlsli"
// 0�ԃX���b�g�ɐݒ肳�ꂽ�e�N�X�`��
Texture2D<float4> tex : register(t0);
// 0�ԃX���b�g�ɐݒ肳�ꂽ�T���v���[
SamplerState smp : register(s0);
// �G���g���[�|�C���g
float4 main(VSOutput input) : SV_TARGET
{
	// ���C�g�̃A���r�G���g�J���[��RGB�Ƃ��ēh��
	return float4(ambientLightColor,1);
}
