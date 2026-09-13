import texture;

public float4 sampling_fwd(
    uint2 tid,
    uint2 canvasSize,
    StructuredBuffer<float4> sampleTex,
    uint2 texSize)
{
    // TODO: Student implementation starts here.

    return float4(1.0, 0.0, 1.0, 1.0);

    // TODO: Student implementation ends here.
}

public void sampling_bwd(
    uint2 tid,
    uint2 canvasSize,
    StructuredBuffer<float4> sampleTex,
    RWStructuredBuffer<Atomic<float>[4]> sampleTexGrad,
    uint2 texSize,
    float4 dOut)
{
    // TODO: Student implementation starts here.

    // TODO: Student implementation ends here.
}
