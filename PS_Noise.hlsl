sampler s0 : register(s0);
float4 p0 :  register(c0);
float4 p1 :  register(c1);

#define dx (p1[0])
#define dy (p1[1])
#define counter (p0[2])
#define clock (p0[3])

#define amplificationFactor 0.1

float randCust(in float2 uv) {
	float noiseX = (frac(sin(dot(uv, float2(12.9898,78.233)      )) * 43758.5453));
	float noiseY = (frac(sin(dot(uv, float2(12.9898,78.233) * 2.0)) * 43758.5453));
	return noiseX * noiseY;
}

float4 main(float2 tex : TEXCOORD0) : COLOR {
	float4 orig;
	orig = tex2D(s0, tex);
	float noise = randCust(tex*(counter/5000)) -0.25;

	return orig+ (noise*amplificationFactor);
}