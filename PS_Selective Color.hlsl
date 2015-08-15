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
#define cutoffR 0.40
#define cutoffG 0.025
#define cutoffB 0.25
#define cutoffY 0.25
#define acceptanceAmplification 5

#define showR 1
#define showG 1
#define showB 1
#define showY 1

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float4 color = tex2D(s0, tex);

	float luminance = (color.r + color.g + color.b)/3;
	float4 gray = {luminance,luminance,luminance, 1};

	float redness		= max ( min ( color.r - color.g , color.r - color.b ) / color.r , 0);
	float greenness		= max ( min ( color.g - color.r , color.g - color.b ) / color.g , 0);
	float blueness		= max ( min ( color.b - color.r , color.b - color.g ) / color.b , 0);
	
	float rgLuminance = (color.r*1.4 + color.g*0.6)/2;
	float rgDiff = abs(color.r-color.g)*1.4;

 	float yellowness = 0.1+rgLuminance*1.2 - color.b - rgDiff;

	float4 accept;
	accept.r  = showR * (redness - cutoffR);
	accept.g  = showG * (greenness - cutoffG);
	accept.b  = showB * (blueness - cutoffB);
	accept[3] = showY * (yellowness - cutoffY);

	float acceptance = max (accept.r, max(accept.g, max(accept.b, max(accept[3],0))));
	float modAcceptance = min (acceptance * acceptanceAmplification, 1);

	float4 result;
	result = modAcceptance * color + (1.0-modAcceptance) * gray;
//	result = float4(redness, greenness,blueness,1);

	return result;
}