(* ::Package:: *)

(* Mathematica Init File *)


Needs["HokahokaW`"];
Needs["NounouW`"];
Needs["ParaparaW`"];


Get[ "PyonpyonW`PyonpyonW`"];
Get[ "PyonpyonW`Colbourn`"];


PPColbournJumpAnnotate[trial_/;PPColbournTrialQ[trial]]:=
Module[{tempret,tempAnnEvt, tempLastJumpToParity=False, tempLastJumpToParityTrueIsSw1=Null},
	tempret=({tempAnnEvt, tempLastJumpToParity, tempLastJumpToParityTrueIsSw1} =
			PPColbournJumpAnnotateImpl[ #, tempLastJumpToParity, tempLastJumpToParityTrueIsSw1];
	  tempAnnEvt)&/@ trial;
	tempret //. If[tempLastJumpToParityTrueIsSw1, {True->"Sw1", False->"Sw2"}, {True->"Sw2", False->"Sw1"}]
];
PPColbournJumpAnnotate[args___]:=Message[PPColbournJumpAnnotate::invalidArgs,{args}];


PPColbournJumpAnnotateImpl[event_/;PPColbournEventQ[event], lastJumpToParity_, lastJumpToParityTrueIsSw1_]:=
Module[{tempLastJumpToParity=lastJumpToParity, tempLastJumpToParityTrueIsSw1 = lastJumpToParityTrueIsSw1},
	If[event[[1]]==="Colbourn",
		Switch[event[[4]],
			$PPColbournSwitches[[2]], (
				tempLastJumpToParity=!tempLastJumpToParity;
				If[tempLastJumpToParityTrueIsSw1==Null,tempLastJumpToParityTrueIsSw1=tempLastJumpToParity];
				If[Xor[tempLastJumpToParityTrueIsSw1, tempLastJumpToParity], 
					Message[PPColbournJumpAnnotateImpl::parityJump, ToString[event]]
				]
			),
			$PPColbournSwitches[[3]], (
				tempLastJumpToParity=!tempLastJumpToParity;
				If[tempLastJumpToParityTrueIsSw1==Null,tempLastJumpToParityTrueIsSw1=!tempLastJumpToParity];
				If[Xor[!tempLastJumpToParityTrueIsSw1, tempLastJumpToParity], 
					Message[PPColbournJumpAnnotateImpl::parityJump, ToString[event]]
				]
			),
			x_/;MemberQ[$PPColbournSwitches[[{5,8,11,13}]],x], tempLastJumpToParity=!tempLastJumpToParity,
			_, Null]
	];
	
	{Join[event,{tempLastJumpToParity}], tempLastJumpToParity, tempLastJumpToParityTrueIsSw1}
];
PPColbournJumpAnnotateImpl[args___]:=Message[PPColbournJumpAnnotateImpl::invalidArgs,{args}];

PPColbournJumpAnnotateImpl::parityJump="Jump was not registered: `1`";
