// ���s�����̐�
static const int DIRLIGHT_NUM = 3;

struct DirLight
{
	float3 lightv;    // ���C�g�ւ̕����̒P�ʃx�N�g��
	float3 lightcolor;    // ���C�g�̐F(RGB)
	uint active;
};

// �_�����̐�
static const int POINTLIGHT_NUM = 3;

struct PointLight
{
	float3 lightpos; // ���C�g���W
	float3 lightcolor; // ���C�g�F(RGB)
	float3 lightatten; // ���C�g���������W��
	uint active;
};

// �X�|�b�g���C�g�̐�
static const int SPOTLIGHT_NUM = 3;

struct SpotLight
{
	float3 lightv; // ���C�g�̌��������̋t�x�N�g��
	float3 lightpos; // ���C�g���W
	float3 lightcolor; // ���C�g�̐F(RGB)
	float3 lightatten; // ���C�g���������W��
	float2 lightfactoranglecos; // ���C�g�����p�x�̃R�T�C��
	uint active;
};

// �p�[�e�B�N���o�b�t�@�[�̓���
struct VSInput
{
	float4 pos : POSITION;				// �ʒu
	float3 normal : NORMAL;				// ���_�@��
	float2 uv : TEXCOORD;				// �e�N�X�`�����W
};

// ���_�V�F�[�_�[����s�N�Z���V�F�[�_�[�ւ̂����Ɏg�p����\����
struct VSOutput
{
	float4 svpos : SV_POSITION;	// �V�X�e���p���_���W
	float3 worldpos : POS;		// ���[���h���W
	float3 normal : NORMAL;		// �@��
	float2 uv : TEXCOORD;		// uv�l
};

cbuffer cbuff0 : register(b0)
{
	matrix viewproj;	// �r���[�v���W�F�N�V�����s��
	matrix world;		// ���[���h���W
	float3 cameraPos;	// �J�������W(���[���h���W)
};

// �}�e���A��
cbuffer cbuff1 : register(b1)
{
	// �A���x�h
	float3 baseColor;
	// �����x
	float metalness;
	// ���ʔ��˓x
	float specular;
	// �e��
	float roughness;
}

// �萔�o�b�t�@(���C�g���)
cbuffer cbuff2 : register(b2)
{
	float3 ambientLightColor;
	DirLight dirLights[DIRLIGHT_NUM];
	PointLight pointLights[POINTLIGHT_NUM];
	SpotLight spotLights[SPOTLIGHT_NUM];
};
