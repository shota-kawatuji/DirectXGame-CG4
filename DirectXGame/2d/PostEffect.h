#pragma once
#include "Sprite.h"
class PostEffect :
    public Sprite
{
public: // �����o�֐�
    /// <summary>
    /// �R���X�g���N�^
    /// </summary>
    PostEffect();

    /// <summary>
    /// ������
    /// </summary>
    void Initialize();

    /// <summary>
    /// �`��R�}���h�̔��s
    /// </summary>
    /// <param name="cmdList">�R�}���h���X�g</param>
    void Draw(ID3D12GraphicsCommandList* cmdList);

private: // �����o�ϐ�
    // �e�N�X�`���o�b�t�@
    ComPtr<ID3D12Resource> texBuff;
    // SRV�p�f�X�N���v�^�q�[�v
    ComPtr<ID3D12DescriptorHeap> descHeapSRV;
};

