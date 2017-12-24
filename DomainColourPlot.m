BeginPackage["DCP`"]

DomainColour::usage = "Computes the associated colour with a complex number."
DomainColourPlot::usage = "Computes domain colouring plot of given complex function."

Options[DomainColourPlot] =
	{
		AspectRatio -> Automatic,
		ImageSize -> Automatic,
		PlotPoints -> 100,
		ImagePadding -> All,
		Frame -> True
	};

Begin["Private`"]

DomainColour[z_] :=
	Hue[
		Arg[z] / (2 \[Pi]),
		1 / (1 + 0.3 Log[Abs[z] + 1]), 
		1 - 1 / (1.1 + 5 Log[Abs[z] + 1])
	]
DomainColourPlot[f_, {xMin_, xMax_}, {yMin_, yMax_}, OptionsPattern[]] :=
	RegionPlot[True,
		{x, xMin, xMax}, {y, yMin, yMax}, 
		ColorFunction -> Function[{x, y}, DomainColour@f[x + I y]],
		ColorFunctionScaling -> False,
		PlotPoints -> OptionValue[PlotPoints], 
		AspectRatio ->
			If[SameQ[OptionValue[AspectRatio], Automatic],
					(yMax - yMin) / (xMax - xMin),
					OptionValue[AspectRatio]
				],
		ImageSize -> OptionValue[ImageSize],
		ImagePadding -> OptionValue[ImagePadding],
		Frame -> OptionValue[Frame]
	]

End[]

EndPackage[]
