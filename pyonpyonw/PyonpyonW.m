(* ::Package:: *)

(* Mathematica Package *)
BeginPackage["PyonpyonW`",{"HokahokaW`","ParaparaW`"}]


HHPackageMessage["PyonpyonW`"];


PPLoadNEVFile::usage=" ";


Begin["`Private`"]


PPLoadNEVFile[file_String]:=
Module[{testEvents, port0, port1, port2},
	{testEvents}=NNDataReader`load[file];
	If[ !HHJavaObjectQ[testEvents, "nounou.data.XEvents"],
		Message[ PPLoadNEVFile::fileIsNotCorrectFormat, file ];,


		Print[]
		Print["Loaded " <> ToString[testEvents@lengths[]] <> " events with port numbers: " <> ToString[testEvents@ports[]]];
		{port0, port1, port2}=(testEvents@ports[])[[2;;]];
	
		Print["Proceeding with analysis for ports " <> ToString[ port1 ] <> " and " <> ToString[ port2 ] ] <> ".";
		Join[
			{#@timestamp[], #@duration[], #@code[]+0}& /@testEvents@filterByPortA[port1],
			{#@timestamp[], #@duration[], #@code[]+1000}& /@testEvents@filterByPortA[port2]
		]
	]
];


PPLoadNEVFile::fileIsNotCorrectFormat="The file `1` is not loadable!";


End[];

EndPackage[];
