(* ::Package:: *)

(* Mathematica Package *)
BeginPackage["PyonpyonW`Colbourn`",{"HokahokaW`","PyonpyonW`"}]


PPCorrectColbournRecordedEvents::usage=" ";
PPCorrectColbournFlow::usage=" ";
$PPColbournSwitches::usage=" ";
$PPColbournSwitches={1, 2, 3, 64, 8,     16, 128, 24, 32, 192,    40,48, 4};


PPPlotTrialNumber=Null;


PPColbournEventQ::usage=" ";
PPColbournTrialQ::usage=" ";


PPColbournTrialGetStimulusDAQ::usage=" ";
PPColbournTrialGetStimulusDAQCode::usage=" ";
PPColbournTrialGetStimulus::usage=" ";
PPColbournTrialGetStartingSide::usage=" ";
PPColbournTrialGetStartingTime::usage=" ";
PPColbournTrialGetType::usage=" ";
PPColbournTrialGetShockRange::usage=" ";


PPColbournTrialContains::usage=" ";


Begin["`Private`"]


(* ::Subsection::Closed:: *)
(*PPCorrectColbournRecordedEvents*)


PPCorrectColbournRecordedEvents[events_List, stepNumber_Integer]:=
Module[{},
	Switch[stepNumber,
		1, PPCorrectColbournRecordedEventsImpl1[events, 1000],
		2, PPCorrectColbournRecordedEventsImpl2[events, 1000],
		3, PPCorrectColbournRecordedEventsImpl3[events, 1000],
		_, Message[PPCorrectColbournRecordedEvents::invalidArgs, {stepNumber}]
	]
];


PPCorrectColbournRecordedEvents[args___]:=Message[PPCorrectColbournRecordedEvents::invalidArgs,{args}];


PPCorrectColbournRecordedEventsImpl3[events_List, bitChangeIntervalMax_]:=
Module[{tempret, tempDel={} },
	tempret = ReplaceRepeated[events, 
		{head___, 
		{"Colbourn", x2_, x3_, x4_, xx__},
		{"Colbourn", y2_, y3_ , y4_, yy__}, 
		{"Colbourn", yB2_, yB3_, yB4_, yyB__}, 
		{"Colbourn", yC2_, yC3_, yC4_, yyC__}, 
		{"Colbourn", z2_, z3_, z4_, zz__}, 
		tail___}/;((z2-y2)<=bitChangeIntervalMax && x4<y4 &&  BitOr[x4, yB4, yC4, z4]==y4 && y4>yB4 && yB4>yC4 && yC4>z4)
		:> 
		(AppendTo[tempDel, y2]; {head, {"Colbourn", x2, x3+y3+yB3+yC3, x4, xx},{"Colbourn", z2, z3, z4, zz}, tail})
	];
	Print["The following timestamps were removed: " <> ToString[tempDel]];
	tempret
];

PPCorrectColbournRecordedEventsImpl3[args___]:=Message[PPCorrectColbournRecordedEventsImpl3::invalidArgs,{args}];


PPCorrectColbournRecordedEventsImpl2[events_List, bitChangeIntervalMax_]:=
Module[{tempret, tempDel={} },
	tempret = ReplaceRepeated[events, 
		{head___, 
		{"Colbourn", x2_, x3_, x4_, xx__},
		{"Colbourn", y2_, y3_, y4_, yy__}, 
		{"Colbourn", yB2_, yB3_, yB4_, yyB__}, 
		{"Colbourn", z2_, z3_, z4_, zz__}, 
		tail___}/;((z2-y2)<=bitChangeIntervalMax && x4<y4 &&  BitOr[x4, yB4, z4]==y4 && y4>yB4 && yB4>z4)
		:> 
		(AppendTo[tempDel, y2]; {head, {"Colbourn", x2, x3+y3+yB3, x4, xx},{"Colbourn", z2, z3, z4, zz}, tail})
	];
	Print["The following timestamps were removed: " <> ToString[tempDel]];
	tempret
];

PPCorrectColbournRecordedEventsImpl2[args___]:=Message[PPCorrectColbournRecordedEventsImpl2::invalidArgs,{args}];


PPCorrectColbournRecordedEventsImpl1[events_List, bitChangeIntervalMax_]:=
Module[{tempret, tempDel={} },
	tempret = ReplaceRepeated[events, 
		{head___, 
		{"Colbourn", x2_, x3_, x4_, xx__},
		{"Colbourn", y2_, y3_, y4_, yy__}, 
		{"Colbourn", z2_, z3_, z4_, zz__}, 
		tail___}/;((z2-y2)<=bitChangeIntervalMax && x4<y4 && BitOr[x4, z4]==y4 && y4>z4)
		:>
		(AppendTo[tempDel, y2]; {head, {"Colbourn", x2, x3+y3, x4, xx},{"Colbourn", z2, z3, z4, zz}, tail})
	];
	Print["The following timestamps were removed: " <> ToString[tempDel]];
	tempret
];

PPCorrectColbournRecordedEventsImpl1[args___]:=Message[PPCorrectColbournRecordedEventsImpl1::invalidArgs,{args}];


(* ::Subsection::Closed:: *)
(*PPCorrectColbournFlow*)


PPCorrectColbournFlow[events_List]:=
Module[{tempEvents},
	tempEvents=events;
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[1]], $PPColbournSwitches[[{2, 3, 4, 7, 10}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[2]], $PPColbournSwitches[[{3, 4, 7, 10}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[3]], $PPColbournSwitches[[{2, 4, 7, 10}]]];

	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[4]], $PPColbournSwitches[[{5, 6}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[5]], $PPColbournSwitches[[{1, 13}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[6]], $PPColbournSwitches[[{1, 13}]]];

	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[7]], $PPColbournSwitches[[{8, 9}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[8]], $PPColbournSwitches[[{1, 13}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[9]], $PPColbournSwitches[[{1, 13}]]];

	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[10]], $PPColbournSwitches[[{11, 12}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[11]], $PPColbournSwitches[[{1, 13}]]];
	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[12]], $PPColbournSwitches[[{1, 13}]]];

	tempEvents=PPCorrectColbournFlowImpl[tempEvents, $PPColbournSwitches[[13]], $PPColbournSwitches[[{1, 2, 3}]]];

	tempEvents

];

PPCorrectColbournFlow[args___]:=Message[PPCorrectColbournFlow::invalidArgs,{args}];


PPCorrectColbournFlowImpl[events_List, first_Integer, next_List]:=
Module[{tempret, tempDel={} },
	tempret = ReplaceRepeated[events, 
		{head___, 
		{"Colbourn", x2_,0, first, xx__},
		{"Colbourn", y2_,0, y4_/;!MemberQ[next, y4], yy__}, 
		{"Colbourn", z2_,0, z4_/;MemberQ[next, z4], zz__}, 
		tail___}
		:> 
		(AppendTo[tempDel, {{x2, first},{y2,y4},{z2,z4}}]; 
		{head, {"Colbourn", x2, 0, first, xx},{"Colbourn", z2,0, z4, zz}, tail})
	];
	If[ Length[tempDel]>0,
		Print["The following 3-trial sequences were removed: \n" <> StringJoin@@((ToString[#]<>"\n")& /@ tempDel)]
	];
	tempret
];

PPCorrectColbournFlowImpl[args___]:=Message[PPCorrectColbournFlowImpl::invalidArgs,{args}];


(* ::Subsection:: *)
(*PPColbournEventQ/PPColbournTrialQ*)


PPColbournEventQ[event_List]:= 
	Depth[event]==2 && MemberQ[{5,6}, Length[event]] && MemberQ[{"Coulbourn", "Neuralynx","Stimulus"},event[[1]]];
PPColbournEventQ[_]:= False;


PPColbournTrialQ[trial_List]:= 
	Depth[trial]==3 && And@@(PPColbournEventQ/@ trial);
PPColbournTrialQ[_]:= False;


(* ::Subsection:: *)
(*PPColbournTrialGetXXX*)


PPColbournTrialGetStimulusDAQ[trial_List/;PPColbournTrialQ[trial]]:= Module[{selectedTrials},
	selectedTrials=Select[trial, (#[[1]]==="Stimulus")&];
	If[ Length[selectedTrials]==1, selectedTrials[[1]],
	If[ Length[selectedTrials]>1, 
		Message[PPColbournTrialGetStimulusDAQ::multiple, selectedTrials];
		selectedTrials[[1]],
	Message[PPColbournTrialGetStimulusDAQ::none];
	Null]]
];

PPColbournTrialGetStimulusDAQ[args___]:=Message[PPColbournTrialGetStimulusDAQ::invalidArgs,{args}];
PPColbournTrialGetStimulusDAQ::multiple="Multiple DAQ Stimulus events, returning First: `1`";
PPColbournTrialGetStimulusDAQ::none="No DAQ Stimulus events, returning Null";


PPColbournTrialGetStimulusDAQCode[trial_List/;PPColbournTrialQ[trial]]:= SelectFirst[trial, (#[[1]]==="Stimulus")&][[4]];

PPColbournTrialGetStimulusDAQCode[args___]:=Message[PPColbournTrialGetStimulusDAQCode::invalidArgs,{args}];


PPColbournTrialGetStimulus[trial_List/;PPColbournTrialQ[trial]]:= Module[{selectedTrials},
	selectedTrials=Select[trial, MemberQ[$PPColbournSwitches[[{4,7,10}]],#[[4]]]&];
	If[ Length[selectedTrials]==1, selectedTrials[[1]],
	If[ Length[selectedTrials]>1, 
		Message[PPColbournTrialGetStimulus::multiple, selectedTrials];
		selectedTrials[[1]],
	Message[PPColbournTrialGetStimulus::none];
	Null]]
];

PPColbournTrialGetStimulus[args___]:=Message[PPColbournTrialGetStimulus::invalidArgs,{args}];
PPColbournTrialGetStimulus::multiple="Multiple stimulus events, returning First: `1`";
PPColbournTrialGetStimulus::none="No stimulus events, returning Null";


PPColbournTrialGetStartingSide[trial_List/;PPColbournTrialQ[trial]]:= PPColbournTrialGetStimulus[trial][[6]];

PPColbournTrialGetStartingSide[args___]:=Message[PPColbournTrialGetStartingSide::invalidArgs,{args}];


PPColbournTrialGetStartingTime[trial_List/;PPColbournTrialQ[trial]]:= PPColbournTrialGetStimulus[trial][[2]];

PPColbournTrialGetStartingTime[args___]:=Message[PPColbournTrialGetStartingTime::invalidArgs,{args}];


PPColbournTrialGetType[trial_List/;PPColbournTrialQ[trial]]:=
	Switch[  PPColbournTrialGetStimulus[trial][[4]],
		$PPColbournSwitches[[4]], "GO",
		$PPColbournSwitches[[7]], "NOGO",
		$PPColbournSwitches[[10]], "TEST",
		_, "INVALID"
];

PPColbournTrialGetType[args___]:=Message[PPColbournTrialGetType::invalidArgs,{args}];


PPColbournTrialGetShockRange[trial_List/;PPColbournTrialQ[trial]]:= 
Module[{tempret, foundcount = 0 },
	tempret = ReplaceRepeated[trial, 
		{head__, 
		{"Colbourn", x2_, x3_, x4_/;MemberQ[$PPColbournSwitches[[{6,8}]],x4], xx__},
		{"Colbourn", y2_, y3_, y4_, yy__}(*/;(y4==$PPColbournSwitches[[13]] || Abs[y3-4000000000]<2000)*), 
		tail___}
		:> 
		(foundcount+=1;{{"Colbourn", x2, x3, x4, xx},{"Colbourn", y2, y3, y4, yy}, tail})
	];

	If[foundcount==0, {}, 
		If[foundcount>1, Message[PPColbournTrialGetShockRange::multiple]];
		tempret[[1;;2, 2]]
	]
];


PPColbournTrialGetShockRange[args___]:=Message[PPColbournTrialGetShockRange::invalidArgs,{args}];
PPColbournTrialGetShockRange::multiple="Multiple shock events, returning First";


(* ::Subsection:: *)
(*PPColbournTrialContains*)


PPColbournTrialContains[trial_List/;PPColbournTrialQ[trial], switchCode_Integer]:= 
Module[{tempret, foundcount = 0 },
	tempret = ReplaceRepeated[trial, 
		{head__, 
		{"Colbourn", y2_, y3_, $PPColbournSwitches[[switchCode]], yy__}, 
		tail___}
		:> 
		(foundcount+=1)
	];

	foundcount!=0
];


PPColbournTrialContains[args___]:=Message[PPColbournTrialContains::invalidArgs,{args}];
PPColbournTrialContains::multiple="Multiple shock events, returning First";


(* ::Section:: *)
(*End*)


End[];

EndPackage[];
