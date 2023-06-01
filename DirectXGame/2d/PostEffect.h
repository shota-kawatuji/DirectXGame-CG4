#pragma once
#include "Sprite.h"
class PostEffect :
    public Sprite
{
public: // メンバ関数
    /// <summary>
    /// コンストラクタ
    /// </summary>
    PostEffect();

    /// <summary>
    /// 初期化
    /// </summary>
    void Initialize();

    /// <summary>
    /// 描画コマンドの発行
    /// </summary>
    /// <param name="cmdList">コマンドリスト</param>
    void Draw(ID3D12GraphicsCommandList* cmdList);

private: // メンバ変数
    // テクスチャバッファ
    ComPtr<ID3D12Resource> texBuff;
    // SRV用デスクリプタヒープ
    ComPtr<ID3D12DescriptorHeap> descHeapSRV;
};

