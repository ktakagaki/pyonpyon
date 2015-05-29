(* ::Package:: *)

(* Mathematica Package *)
BeginPackage["PyonpyonW`Parsing`",{"HokahokaW`","PyonpyonW`"}]


(*Here, before we go into Private scope, we can declare everything we need*)


PP2ExtractTrial::usage = "This is how to use PP2ExtractTrial";


PP2TrialType::usage="This is how to use ";
PP2TrialTypeList::usage="This is how to use ";


(* ::Section:: *)
(*Private scope*)


Begin["`Private`"]


(* ::Subsection:: *)
(*PP2ExtractTrial*)


PP2ExtractTrial[data_, trialNo_]:=
Module[{tempTrials},
	tempTrials=Replace[
		data, 
		{head1___,
			{"STATE", trialNo-1, tail2__},
			Longest[contents__],
			{"STATE", trialNo-1, tail3__},
		tail1___}
				:>{{"STATE", trialNo-1, tail2},contents,{"STATE", trialNo-1, tail3}}
	];
	Select[tempTrials,(#[[1]]=="STATE" || #[[1]]=="TRIAL")&]
];


(* ::Subsection:: *)
(*PP2TrialType/PP2TrialTypeList*)


PP2TrialType[testData_]:= 
Module[{tempret},
	tempret=Cases[testData, {"TRIAL",___}][[All, 2]] ;

	If[Length[tempret]!=1, 
		Message[PP2TrialTypeList::trialError],
		tempret=tempret[[1]]
	];
	Replace[tempret, {1 -> "GO", 2-> "NOGO", _->"Invalid!"} ]
];


PP2TrialTypeList[testData_]:= 
Module[{tempret},
	tempret=Cases[testData, {"TRIAL",___}][[All, 2]] ;
	
	If[Length[tempret]==0, 
		Message[PP2TrialTypeList::trialError](*,
		tempret=tempret[[1]]*)
	];
	Replace[ #, {1 -> "GO", 2-> "NOGO", _->"Invalid!"} ]& /@ tempret
];


PP2TrialTypeList::trialError="Something is wrong with this trial!";


(* ::Section:: *)
(*End*)


End[];

EndPackage[];
