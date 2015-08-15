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

	if (pixelY % 2 ==1) {
		pixelX += sin(counter/5)*10;
	}

	tex.x = pixelX / width;
	tex.y = pixelY / height;
		

	float4 c0 = tex2D(s0, tex);

	return c0;
}