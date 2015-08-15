sampler s0 : register(s0);
float4 p0 : register(c0);
float4 p1 : register(c1);

#define width (p0[0])
#define height (p0[1])
#define counter (p0[2])
#define clock (p0[3])
#define one_over_width (p1[0])
#define one_over_height (p1[1])

#define PI acos(-1)

float4 main(float2 tex : TEXCOORD0) : COLOR {

	float4 source = tex2D(s0, tex);

	double4 result;
	result.r = (float)source.r;
	result.g =(float)source.g;
	result.b = (float)source.b;
	result.a = (float)1.0;

	double saturationRate =20.0;

	double luminance = (source.r + source.g + source.b)/3.0;

	double currentSaturation = ((abs(result.r-luminance) + abs(result.g-luminance) + abs(result.b-luminance))/3.0) * (1.0-luminance);
	double currentSaturationCompensation = (1.0 - currentSaturation)/10.0;

	double4 moreVibrant = result;
	double4 lessVibrant = result;
	double4 moreSaturated = result;

	moreVibrant.r += (result.r-luminance) * saturationRate * currentSaturation;
	moreVibrant.g += (result.g-luminance) * saturationRate * currentSaturation;
	moreVibrant.b += (result.b-luminance) * saturationRate * currentSaturation;

	lessVibrant.r += (result.r-luminance) * saturationRate * currentSaturationCompensation;
	lessVibrant.g += (result.g-luminance) * saturationRate * currentSaturationCompensation;
	lessVibrant.b += (result.b-luminance) * saturationRate * currentSaturationCompensation;

	moreSaturated.r += (result.r-luminance) * saturationRate * luminance;
	moreSaturated.g += (result.g-luminance) * saturationRate * luminance;
	moreSaturated.b += (result.b-luminance) * saturationRate * luminance;

// 	result = lessVibrant;
// 	result = moreSaturated;
 	result = moreVibrant;
//	result = source;

	return result;

}