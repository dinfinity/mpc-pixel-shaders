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

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	int pixelX = tex.x*width;
	int pixelY = tex.y*height;


//	float4 draw = {cos(counter/10),sin(counter),0,1}; // Psychedelic flashing;
	float4 draw = {cos(counter/10),sin(counter),0,1};
	draw = draw * cos(tex.x*120);
	draw = draw * cos(tex.y*120);

	

	float4 c0 = tex2D(s0, tex);
	c0 = c0 * draw;

	return c0;
}