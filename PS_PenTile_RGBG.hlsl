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
#define pixelSize 3 // minimum = 3

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	int pixelX = (int)(tex.x*width);
	int pixelY = (int)(tex.y*height);
	int xType = (pixelX % pixelSize)/(pixelSize/3);
	int yType = (pixelY % (pixelSize*2))/(pixelSize);
	int xType2 = xType;
	if (xType2 == 1) {xType2 = 0;}

	int sourcePixelX = pixelX - (pixelX % pixelSize) + xType2 * (pixelSize/3);
	int sourcePixelY = pixelY - (pixelY % pixelSize) + yType * (pixelSize/2);
	float2 sourceTex = {one_over_width * sourcePixelX, one_over_height * sourcePixelY};
	float4 sourceColor = tex2D(s0, sourceTex);

	 if (xType == 2) {
		// Green
		sourceColor[0] = 0;
		sourceColor[2] = 0;
	} else {
		if (yType == ((pixelX / pixelSize)%2)){
			// Red
			sourceColor[1] = 0;
			sourceColor[2] = 0;
		} else {
			// Blue;
			sourceColor[1] = 0;
			sourceColor[0] = 0;
		}
	}	
	return sourceColor;
}