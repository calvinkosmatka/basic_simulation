function [disTree,indexx,pos,trying111] = simulWithRc7(div1,div2,numGene,recomRate,simulTime,input,u)
initialTree = simul6(div1,div2,numGene,simulTime);
total = numGene*simulTime;
temping111 = [];
initialTree2 = initialTree';
initialStayTry = 0;
[shorter,initialGraphType] = min(initialTree2);
longer = max(initialTree2);
temp1 = shorter - div1;
temp2 = find(temp1>=0);
initialGraphType(temp2) = initialGraphType (temp2) +1;
eachGraphType = initialGraphType;
%goal = ones(1,numGene);
totalLengthOfTheInitial = (sum(initialTree,2))';
expOfTotalLength = random('exp',( (totalLengthOfTheInitial.^-1)/recomRate));
%index1 = find(expTotal >= 1);
%num = 11; % need to fix 
whileLoopIteration = 0;
indexingStopInitially = (expOfTotalLength>=1);
howManyStopInitially = sum(indexingStopInitially);
numberIndexNotDoneIni = find(expOfTotalLength<1);
%logicalNotDoneIni = (expTotal<1);
howManyNotDoneInitially = total-howManyStopInitially;
sumOfTotalWeight = zeros(1,howManyNotDoneInitially);


longer(indexingStopInitially) = [];
shorter(indexingStopInitially) = [];

initialGraphType(indexingStopInitially) = [];
expOfTotalLength(indexingStopInitially) = 1;
%modify the initialTree to the final result step by step
initialTree = [times(expOfTotalLength',initialTree(:,1)),times(expOfTotalLength',initialTree(:,2)),times(expOfTotalLength',initialTree(:,3))];
goal = howManyNotDoneInitially;
treeThatNotStop = zeros(goal,3);
totalLengthOfTheInitial(indexingStopInitially) = [];
expOfTotalLength(indexingStopInitially) = [];
sumOfTotalWeight = sumOfTotalWeight + expOfTotalLength;
eachGraphType = [eachGraphType;initialGraphType, zeros(1,howManyStopInitially)];
while goal > 0
%generate al the random numbers here

uniformCoalWhenRateisTwo = random('Discrete Uniform',2,[2, goal]);
expRate1 = random('exp',1,[3,goal]);
expRate2 = random('exp',1/2,[2,goal]);
expRate1Temp1 = expRate1(1,:);
expRate2Temp1 = expRate2(1,:);
uniformCoalWhenRateisTwoTemp1 = uniformCoalWhenRateisTwo(1,:);
expRate1Temp2 = expRate1(2,:);
expRate2Temp2 = expRate2(2,:);
uniformCoalWhenRateisTwoTemp2 = uniformCoalWhenRateisTwo(2,:);
expRate1Temp3 = expRate1(3,:);


%random Initial Postion
randomUniformInitialPointOfRecom = random('uniform',0,totalLengthOfTheInitial);
randomUni1 = randomUniformInitialPointOfRecom - shorter;
randomUni2 = randomUniformInitialPointOfRecom - shorter*2;
randomUni3 = randomUniformInitialPointOfRecom - shorter - longer;
%randomUni4 = randomUniformInitialPointOfRecom - shorter-2*longer;


indexBranchOne = (randomUni1 < 0);
indexBranchTwo = (randomUni2 < 0 & (randomUni1) >= 0);
indexBranchThree = (randomUni3 < 0 & (randomUni2) >= 0);
indexBranchFour = (randomUni3 >= 0);

%indexBranchFourTry1 = ((randomUni4+longer) <= div1 & (randomUni4+longer) >= 0);
%indexBranchThreeTry1 = and((randomUni3 < 0 & (randomUni3+longer) <= div1),indexBranchThree);
%indexBranchTwoTry1 = and((randomUni2< 0 & (randomUni2+shorter) <= div1),indexBranchTwo);
randomUniformInitialPointOfRecom(indexBranchTwo) = randomUniformInitialPointOfRecom(indexBranchTwo) - shorter(indexBranchTwo);
randomUniformInitialPointOfRecom(indexBranchThree) = randomUniformInitialPointOfRecom(indexBranchThree) - shorter(indexBranchThree);
randomUniformInitialPointOfRecom(indexBranchFour) = randomUniformInitialPointOfRecom(indexBranchFour) - (shorter(indexBranchFour)+longer(indexBranchFour));

indexIniSmallerThanDiv2 = (randomUniformInitialPointOfRecom < div2);
randomUniformInitialPointOfRecom(indexIniSmallerThanDiv2)= div2;

%indexIniSmallerThanDiv1Temp1 = (randomUniformInitialPointOfRecom < div1);
%indexIniSmallerThanCoal1Temp1 = ((randomUniformInitialPointOfRecom-shorter) < 0);

indexGraph1 = (initialGraphType ==1);
indexGraph2 = (initialGraphType ==2);
indexGraph3 = (initialGraphType ==3);
indexGraph4 = (initialGraphType ==4);
type1 = and(indexGraph1,indexBranchOne);
type2 = and(indexGraph1,indexBranchTwo);
type3 = and(indexGraph1,indexBranchThree);
type4 = and(indexGraph1,indexBranchFour);
type5 = and(indexGraph2,indexBranchOne);
type6 = and(indexGraph2,indexBranchTwo);
type7 = and(indexGraph2,indexBranchThree);
type8 = and(indexGraph2,indexBranchFour);
type9 = and(indexGraph3,indexBranchOne);
type10 = and(indexGraph3,indexBranchTwo);
type11 = and(indexGraph3,indexBranchThree);
type12 = and(indexGraph3,indexBranchFour);
type13 = and(indexGraph4,indexBranchOne);
type14 = and(indexGraph4,indexBranchTwo);
type15 = and(indexGraph4,indexBranchThree);
type16 = and(indexGraph4,indexBranchFour);

%test 
initialStayTry = initialStayTry + sum(type3) + sum(type4);
%trying4 =  sum(type3) + sum(type4);

indexingUniFirstRowIsOne = (uniformCoalWhenRateisTwoTemp1 == 1);
indexingUniFirstRowIsTwo = (uniformCoalWhenRateisTwoTemp1 == 2);
indexingUniSecondRowIsOne = (uniformCoalWhenRateisTwoTemp2 == 1);
indexingUniSecondRowIsTwo = (uniformCoalWhenRateisTwoTemp2 == 2);

indexIniSmallerThanDiv1Temp1 = (randomUniformInitialPointOfRecom < div1);
indexIniSmallerThanCoal1Temp1 = ((randomUniformInitialPointOfRecom-shorter) < 0);

indexThatCoalBelowDiv1Temp1 = ((randomUniformInitialPointOfRecom+expRate1Temp1-div1)<0);
indexThatCoalBelowCoal1Temp1 = ((randomUniformInitialPointOfRecom+expRate1Temp1-shorter)<0);


%begin the first column of the matrix
%for type 1 to 4 (3,4 rate 0, ignore)
type1AndInitialBelowCoal1 = and(type1,indexIniSmallerThanCoal1Temp1);
type2AndInitialBelowCoal1 = and(type2,indexIniSmallerThanCoal1Temp1);
type3AndInitialBelowCoal1 = and(type3,indexIniSmallerThanCoal1Temp1);
type4AndInitialBelowCoal1 = and(type4,indexIniSmallerThanCoal1Temp1);
type1AndInitialBelowCoal1AndCoalBelowCoal1 = and(type1AndInitialBelowCoal1,indexThatCoalBelowCoal1Temp1);
type2AndInitialBelowCoal1AndCoalBelowCoal1 = and(type2AndInitialBelowCoal1,indexThatCoalBelowCoal1Temp1);
initialStayTry = initialStayTry + sum(type1AndInitialBelowCoal1AndCoalBelowCoal1)+sum(type2AndInitialBelowCoal1AndCoalBelowCoal1);
shorter(type1AndInitialBelowCoal1AndCoalBelowCoal1) = randomUniformInitialPointOfRecom(type1AndInitialBelowCoal1AndCoalBelowCoal1) + expRate1Temp1(type1AndInitialBelowCoal1AndCoalBelowCoal1);
shorter(type2AndInitialBelowCoal1AndCoalBelowCoal1) = randomUniformInitialPointOfRecom(type2AndInitialBelowCoal1AndCoalBelowCoal1) + expRate1Temp1(type2AndInitialBelowCoal1AndCoalBelowCoal1);
randomUniformInitialPointOfRecom(xor(type1AndInitialBelowCoal1,type1AndInitialBelowCoal1AndCoalBelowCoal1)) = shorter(xor(type1AndInitialBelowCoal1,type1AndInitialBelowCoal1AndCoalBelowCoal1));
randomUniformInitialPointOfRecom(xor(type2AndInitialBelowCoal1,type2AndInitialBelowCoal1AndCoalBelowCoal1)) = shorter(xor(type2AndInitialBelowCoal1,type2AndInitialBelowCoal1AndCoalBelowCoal1));
randomUniformInitialPointOfRecom(type3AndInitialBelowCoal1) = shorter(type3AndInitialBelowCoal1);
randomUniformInitialPointOfRecom(type4AndInitialBelowCoal1) = shorter(type4AndInitialBelowCoal1);

%for type 5 to 8 (ignore type 7 and 8)
type5AndInitialBelowDiv1 = and(type5,indexIniSmallerThanDiv1Temp1);
type6AndInitialBelowDiv1 = and(type6,indexIniSmallerThanDiv1Temp1);
type5AndInitialBelowDiv1AndCoalBelowDiv1 = and(type5AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
type6AndInitialBelowDiv1AndCoalBelowDiv1 = and(type6AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
shorter(type5AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type5AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type5AndInitialBelowDiv1AndCoalBelowDiv1);
shorter(type6AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type6AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type6AndInitialBelowDiv1AndCoalBelowDiv1);
randomUniformInitialPointOfRecom(xor(type5AndInitialBelowDiv1,type5AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
randomUniformInitialPointOfRecom(xor(type6AndInitialBelowDiv1,type6AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
initialGraphType(type5AndInitialBelowDiv1AndCoalBelowDiv1) =1;
initialGraphType(type6AndInitialBelowDiv1AndCoalBelowDiv1) =1;
type7AndInitialBelowDiv1 = and(type7,indexIniSmallerThanDiv1Temp1);
type8AndInitialBelowDiv1 = and(type8,indexIniSmallerThanDiv1Temp1);
randomUniformInitialPointOfRecom(type7AndInitialBelowDiv1) = div1;
randomUniformInitialPointOfRecom(type8AndInitialBelowDiv1) = div1;

%for type 9 to 12 (ignore type10,11)
type9AndInitialBelowDiv1 = and(type9,indexIniSmallerThanDiv1Temp1);
type12AndInitialBelowDiv1= and(type12,indexIniSmallerThanDiv1Temp1);
type9AndInitialBelowDiv1AndCoalBelowDiv1 = and(type9AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
type12AndInitialBelowDiv1AndCoalBelowDiv1 = and(type12AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
shorter(type9AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type9AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type9AndInitialBelowDiv1AndCoalBelowDiv1);
longer(type12AndInitialBelowDiv1AndCoalBelowDiv1) = shorter(type12AndInitialBelowDiv1AndCoalBelowDiv1);
shorter(type12AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type12AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type12AndInitialBelowDiv1AndCoalBelowDiv1);
randomUniformInitialPointOfRecom(xor(type9AndInitialBelowDiv1,type9AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
randomUniformInitialPointOfRecom(xor(type12AndInitialBelowDiv1,type12AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
initialGraphType(type9AndInitialBelowDiv1AndCoalBelowDiv1) =1;
initialGraphType(type12AndInitialBelowDiv1AndCoalBelowDiv1) =1;
type10AndInitialBelowDiv1 = and(type10,indexIniSmallerThanDiv1Temp1);
type11AndInitialBelowDiv1 = and(type11,indexIniSmallerThanDiv1Temp1);
randomUniformInitialPointOfRecom(type11AndInitialBelowDiv1)=div1;
randomUniformInitialPointOfRecom(type10AndInitialBelowDiv1)=div1;

%for type 13 to 16 (ignore type 14.15)
type13AndInitialBelowDiv1 = and(type13,indexIniSmallerThanDiv1Temp1);
type16AndInitialBelowDiv1 = and(type16,indexIniSmallerThanDiv1Temp1);
type13AndInitialBelowDiv1AndCoalBelowDiv1 = and(type13AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
type16AndInitialBelowDiv1AndCoalBelowDiv1 = and(type16AndInitialBelowDiv1,indexThatCoalBelowDiv1Temp1);
shorter(type13AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type13AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type13AndInitialBelowDiv1AndCoalBelowDiv1);
longer(type16AndInitialBelowDiv1AndCoalBelowDiv1) = shorter(type16AndInitialBelowDiv1AndCoalBelowDiv1);
shorter(type16AndInitialBelowDiv1AndCoalBelowDiv1) = randomUniformInitialPointOfRecom(type16AndInitialBelowDiv1AndCoalBelowDiv1) + expRate1Temp1(type16AndInitialBelowDiv1AndCoalBelowDiv1);
randomUniformInitialPointOfRecom(xor(type13AndInitialBelowDiv1,type13AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
randomUniformInitialPointOfRecom(xor(type16AndInitialBelowDiv1,type16AndInitialBelowDiv1AndCoalBelowDiv1)) = div1;
initialGraphType(type13AndInitialBelowDiv1AndCoalBelowDiv1) =1;
initialGraphType(type16AndInitialBelowDiv1AndCoalBelowDiv1) =1;
type14AndInitialBelowDiv1 = and(type14,indexIniSmallerThanDiv1Temp1);
type15AndInitialBelowDiv1 = and(type15,indexIniSmallerThanDiv1Temp1);
randomUniformInitialPointOfRecom(type14AndInitialBelowDiv1)=div1;
randomUniformInitialPointOfRecom(type15AndInitialBelowDiv1)=div1;
% start the column2,

indexIniSmallerThanCoal1Temp2 = ((randomUniformInitialPointOfRecom-shorter) < 0 & randomUniformInitialPointOfRecom >= div1 );
indexIniSmallerThanDiv1Temp2 = ((randomUniformInitialPointOfRecom-shorter) >= 0 & randomUniformInitialPointOfRecom < div1 );

indexThatCoalBelowDiv1Temp2 = ((randomUniformInitialPointOfRecom+expRate1Temp2-div1)<0);

indexThatCoalBelowCoal1Temp2 = ((randomUniformInitialPointOfRecom+expRate2Temp1-shorter)<0);
indexing211 = and(indexThatCoalBelowCoal1Temp2,indexingUniFirstRowIsOne);
indexing212 = and(indexThatCoalBelowCoal1Temp2,indexingUniFirstRowIsTwo);
%type 1 to 4, ingore 3,4, 

type1Temping2 = and(type1,indexIniSmallerThanDiv1Temp2);
type2Temping2 = and(type2,indexIniSmallerThanDiv1Temp2);
type3Temp2 = and(type3,indexIniSmallerThanDiv1Temp2);
type4Temp2 = and(type4,indexIniSmallerThanDiv1Temp2);

type1Temp2 = and(type1Temping2,indexThatCoalBelowDiv1Temp2);
type2Temp2 = and(type2Temping2,indexThatCoalBelowDiv1Temp2);
initialStayTry = initialStayTry + sum(type1Temp2) + sum(type2Temp2);
shorter(type1Temp2) = randomUniformInitialPointOfRecom(type1Temp2) + expRate1Temp1(type1Temp2);
shorter(type2Temp2) = randomUniformInitialPointOfRecom(type2Temp2) + expRate1Temp1(type2Temp2);
randomUniformInitialPointOfRecom(xor(type1Temping2,type1Temp2)) = div1;
randomUniformInitialPointOfRecom(xor(type2Temping2,type2Temp2)) = div1;
randomUniformInitialPointOfRecom(type3Temp2) = div1;
randomUniformInitialPointOfRecom(type4Temp2) = div1;
% for type 5 to 8, ignore type 7
type5Temping2 = and(type5,indexIniSmallerThanCoal1Temp2);
type6Temping2 = and(type6,indexIniSmallerThanCoal1Temp2);
type5Temp21 = and(type5Temping2,indexing211);
type5Temp22 = and(type5Temping2,indexing212);
type6Temp21 = and(type6Temping2,indexing211);
type6Temp22 = and(type6Temping2,indexing212);
shorter(type5Temp21) = expRate2Temp1(type5Temp21) + randomUniformInitialPointOfRecom(type5Temp21);
shorter(type5Temp22) = expRate2Temp1(type5Temp22) + randomUniformInitialPointOfRecom(type5Temp22);
initialGraphType(type5Temp22) = 3;


shorter(type6Temp21) = expRate2Temp1(type6Temp21) + randomUniformInitialPointOfRecom(type6Temp21);
shorter(type6Temp22) = expRate2Temp1(type6Temp22) + randomUniformInitialPointOfRecom(type6Temp22);
initialGraphType(type6Temp22) = 4;

type8Temping2 = and(type8,indexIniSmallerThanCoal1Temp2);
type8Temp21 = and(type8Temping2,indexing211);
type8Temp22 = and(type8Temping2,indexing212);
longer(type8Temp21) = shorter(type8Temp21);
longer(type8Temp22) = shorter(type8Temp22);
shorter(type8Temp21) = expRate2Temp1(type8Temp21) + randomUniformInitialPointOfRecom(type8Temp21);
shorter(type8Temp22) = expRate2Temp1(type8Temp22) + randomUniformInitialPointOfRecom(type8Temp22);
initialGraphType(type8Temp21) = 3;
initialGraphType(type8Temp22) = 4;
type5Temp2 = or(type5Temp21,type5Temp22);
type6Temp2 = or(type6Temp21,type6Temp22);
type8Temp2 = or(type8Temp21,type8Temp22);
randomUniformInitialPointOfRecom(xor(type5Temp2,type5Temping2)) = shorter(xor(type5Temp2,type5Temping2));
randomUniformInitialPointOfRecom(xor(type6Temp2,type6Temping2)) = shorter(xor(type6Temp2,type6Temping2));
randomUniformInitialPointOfRecom(xor(type8Temp2,type8Temping2)) = shorter(xor(type8Temp2,type8Temping2));
type7Temp2 = and(type7,indexIniSmallerThanCoal1Temp2);

randomUniformInitialPointOfRecom(type7Temp2) = shorter(type7Temp2);

% for type 9 to 12,ignore 11

type9Temping2 = and(type9,indexIniSmallerThanCoal1Temp2);
type10Temping2 = and(type10,indexIniSmallerThanCoal1Temp2);
type9Temp21 = and(type9Temping2,indexing211);
type9Temp22 = and(type9Temping2,indexing212);
type10Temp21 = and(type10Temping2,indexing211);
type10Temp22 = and(type10Temping2,indexing212);
shorter(type9Temp21) = expRate2Temp1(type9Temp21) + randomUniformInitialPointOfRecom(type9Temp21);
shorter(type9Temp22) = expRate2Temp1(type9Temp22) + randomUniformInitialPointOfRecom(type9Temp22);
initialGraphType(type9Temp21) = 2;


shorter(type10Temp21) = expRate2Temp1(type10Temp21) + randomUniformInitialPointOfRecom(type10Temp21);
shorter(type10Temp22) = expRate2Temp1(type10Temp22) + randomUniformInitialPointOfRecom(type10Temp22);
initialGraphType(type10Temp22) = 4;
type11Temp2 = and(type11,indexIniSmallerThanCoal1Temp2);

randomUniformInitialPointOfRecom(type11Temp2) = shorter(type11Temp2);
type12Temping2 = and(type12,indexIniSmallerThanCoal1Temp2);
type12Temp21 = and(type12Temping2,indexing211);
type12Temp22 = and(type12Temping2,indexing212);
longer(type12Temp21)=shorter(type12Temp21);
longer(type12Temp22)=shorter(type12Temp22);
shorter(type12Temp21) = expRate2Temp1(type12Temp21) + randomUniformInitialPointOfRecom(type12Temp21);
shorter(type12Temp22) = expRate2Temp1(type12Temp22) + randomUniformInitialPointOfRecom(type12Temp22);
initialGraphType(type12Temp21) = 2;
initialGraphType(type12Temp22) = 4;
type9Temp2 = or(type9Temp21,type9Temp22);
type10Temp2 = or(type10Temp21,type10Temp22);
type12Temp2 = or(type12Temp21,type12Temp22);
randomUniformInitialPointOfRecom(xor(type9Temp2,type9Temping2)) = shorter(xor(type9Temp2,type9Temping2));
randomUniformInitialPointOfRecom(xor(type10Temp2,type10Temping2)) = shorter(xor(type10Temp2,type10Temping2));
randomUniformInitialPointOfRecom(xor(type12Temp2,type12Temping2)) = shorter(xor(type12Temp2,type12Temping2));
%for type13 to 16, ignore 15
type13Temping2 = and(type13,indexIniSmallerThanCoal1Temp2);
type14Temping2 = and(type14,indexIniSmallerThanCoal1Temp2);
type13Temp21 = and(type13Temping2,indexing211);
type13Temp22 = and(type13Temping2,indexing212);
type14Temp21 = and(type14Temping2,indexing211);
type14Temp22 = and(type14Temping2,indexing212);
shorter(type13Temp21) = expRate2Temp1(type13Temp21) + randomUniformInitialPointOfRecom(type13Temp21);
shorter(type13Temp22) = expRate2Temp1(type13Temp22) + randomUniformInitialPointOfRecom(type13Temp22);
initialGraphType(type13Temp21) = 2;


shorter(type14Temp21) = expRate2Temp1(type14Temp21) + randomUniformInitialPointOfRecom(type14Temp21);
shorter(type14Temp22) = expRate2Temp1(type14Temp22) + randomUniformInitialPointOfRecom(type14Temp22);
initialGraphType(type14Temp21) = 3;

type16Temping2 = and(type16,indexIniSmallerThanCoal1Temp2);
type16Temp21 = and(type16Temping2,indexing211);
type16Temp22 = and(type16Temping2,indexing212);
longer(type16Temp21)=shorter(type16Temp21);
longer(type16Temp22)=shorter(type16Temp22);
shorter(type16Temp21) = expRate2Temp1(type16Temp21) + randomUniformInitialPointOfRecom(type16Temp21);
shorter(type16Temp22) = expRate2Temp1(type16Temp22) + randomUniformInitialPointOfRecom(type16Temp22);
initialGraphType(type16Temp21) = 2;
initialGraphType(type16Temp22) = 3;
type13Temp2 = or(type13Temp21,type13Temp22);
type14Temp2 = or(type14Temp21,type14Temp22);
type16Temp2 = or(type16Temp21,type16Temp22);
type15Temp2 = and(type15,indexIniSmallerThanCoal1Temp2);

randomUniformInitialPointOfRecom(type15Temp2) = shorter(type15Temp2);
randomUniformInitialPointOfRecom(xor(type13Temp2,type13Temping2)) = shorter(xor(type13Temp2,type13Temping2));
randomUniformInitialPointOfRecom(xor(type14Temp2,type14Temping2)) = shorter(xor(type14Temp2,type14Temping2));
randomUniformInitialPointOfRecom(xor(type16Temp2,type16Temping2)) = shorter(xor(type16Temp2,type16Temping2));
% start column3

indexIniSmallerThanCoal2 = ((randomUniformInitialPointOfRecom-longer) < 0 & (randomUniformInitialPointOfRecom-max(shorter,div1)) >= 0);
%indexIniSmallerThanCoal2ForGraphOne = ((randomUniformInitialPointOfRecom-longer) < 0 & (randomUniformInitialPointOfRecom-div1) >= 0);
indexThatCoalBelowCoal1Rate2 = ((randomUniformInitialPointOfRecom+expRate2Temp1-longer)<0);
indexing211 = and(indexThatCoalBelowCoal1Rate2,indexingUniFirstRowIsOne);
indexing212 = and(indexThatCoalBelowCoal1Rate2,indexingUniFirstRowIsTwo);
indexThatCoalBelowCoal2Temp3 = ((randomUniformInitialPointOfRecom+expRate1Temp1-longer)<0);
indexThatCoalBelowCoal2Temp33 = ((randomUniformInitialPointOfRecom+expRate1Temp2-longer)<0);
indexing22 = ((randomUniformInitialPointOfRecom+expRate2Temp2-longer)<0);
indexing221 = and(indexing22,indexingUniSecondRowIsOne);
indexing222 = and(indexing22,indexingUniSecondRowIsTwo);

%for type 1 to 4
type1Temping3 = and(type1,indexIniSmallerThanCoal2);
type2Temping3 = and(type2,indexIniSmallerThanCoal2);
type1Temp31 = and(type1Temping3,indexing211);
type1Temp32 = and(type1Temping3,indexing212);
type2Temp31 = and(type2Temping3,indexing211);
type2Temp32 = and(type2Temping3,indexing212);
initialGraphType(type1Temp31) = 2;
initialGraphType(type1Temp32) = 3;
initialGraphType(type2Temp31) = 2;
initialGraphType(type2Temp32) = 4;
type1Temp3 = or(type1Temp31,type1Temp32);
type2Temp3 = or(type2Temp31,type2Temp32);
shorter(type1Temp3) = randomUniformInitialPointOfRecom(type1Temp3)+expRate2Temp1(type1Temp3);
shorter(type2Temp3) = randomUniformInitialPointOfRecom(type2Temp3)+expRate2Temp1(type2Temp3);
type3Temping3 = and(type3,indexIniSmallerThanCoal2);
type4Temping3 = and(type4,indexIniSmallerThanCoal2);
type3Temp3 = and(type3Temping3,indexThatCoalBelowCoal2Temp3);
type4Temp3 = and(type4Temping3,indexThatCoalBelowCoal2Temp3);
longer(type3Temp3) = randomUniformInitialPointOfRecom(type3Temp3)+expRate1Temp1(type3Temp3);
longer(type4Temp3) = randomUniformInitialPointOfRecom(type4Temp3)+expRate1Temp1(type4Temp3);



randomUniformInitialPointOfRecom(xor(type1Temp3,type1Temping3)) = longer(xor(type1Temp3,type1Temping3));
randomUniformInitialPointOfRecom(xor(type2Temp3,type2Temping3)) = longer(xor(type2Temp3,type2Temping3));
randomUniformInitialPointOfRecom(xor(type3Temp3,type3Temping3)) = longer(xor(type3Temp3,type3Temping3));
randomUniformInitialPointOfRecom(xor(type4Temp3,type4Temping3)) = longer(xor(type4Temp3,type4Temping3));

% for type 5 to 8
type5Temping3 = and(type5,indexIniSmallerThanCoal2);
type6Temping3 = and(type6,indexIniSmallerThanCoal2);
type5Temp31 = and(type5Temping3,indexing221);
type5Temp32 = and(type5Temping3,indexing222);
type6Temp31 = and(type6Temping3,indexing221);
type6Temp32 = and(type6Temping3,indexing222);
type5Temp3 = or(type5Temp31,type5Temp32);
type6Temp3 = or(type6Temp31,type6Temp32);
initialGraphType(type5Temp32) = 3;

initialGraphType(type6Temp32) = 4;
shorter(type5Temp3) = randomUniformInitialPointOfRecom(type5Temp3)+expRate2Temp2(type5Temp3);
shorter(type6Temp3) = randomUniformInitialPointOfRecom(type6Temp3)+expRate2Temp2(type6Temp3);

type7Temping3 = and(type7,indexIniSmallerThanCoal2);
type8Temping3 = and(type8,indexIniSmallerThanCoal2);
type7Temp3 = and(type7Temping3,indexThatCoalBelowCoal2Temp3);
type8Temp3 = and(type8Temping3,indexThatCoalBelowCoal2Temp3);
longer(type7Temp3) = randomUniformInitialPointOfRecom(type7Temp3)+expRate1Temp1(type7Temp3);
longer(type8Temp3) = randomUniformInitialPointOfRecom(type8Temp3)+expRate1Temp1(type8Temp3);

randomUniformInitialPointOfRecom(xor(type5Temp3,type5Temping3)) = longer(xor(type5Temp3,type5Temping3));
randomUniformInitialPointOfRecom(xor(type6Temp3,type6Temping3)) = longer(xor(type6Temp3,type6Temping3));
randomUniformInitialPointOfRecom(xor(type7Temp3,type7Temping3)) = longer(xor(type7Temp3,type7Temping3));
randomUniformInitialPointOfRecom(xor(type8Temp3,type8Temping3)) = longer(xor(type8Temp3,type8Temping3));

% for type 9 to 12

type9Temping3 = and(type9,indexIniSmallerThanCoal2);
type10Temping3 = and(type10,indexIniSmallerThanCoal2);
type9Temp31 = and(type9Temping3,indexing221);
type9Temp32 = and(type9Temping3,indexing222);
type10Temp31 = and(type10Temping3,indexing221);
type10Temp32 = and(type10Temping3,indexing222);

initialGraphType(type9Temp31) = 2;
initialGraphType(type10Temp32) = 4;
type9Temp3 = or(type9Temp31,type9Temp32);
type10Temp3 = or(type10Temp31,type10Temp32);
shorter(type9Temp3) = randomUniformInitialPointOfRecom(type9Temp3)+expRate2Temp2(type9Temp3);
shorter(type10Temp3) = randomUniformInitialPointOfRecom(type10Temp3)+expRate2Temp2(type10Temp3);
%type9Temp3 = or(type9Temp31,type9Temp32);
%type10Temp3 = or(type10Temp31,type10Temp32);
%type11Temp3 = or(type11Temp31,type11Temp32);
%type12Temp3 = or(type12Temp31,type12Temp32);
%randomUniformInitialPointOfRecom(xor(type9Temp3,type9Temping3)) = longer(xor(type9Temp3,type9Temping3));
%randomUniformInitialPointOfRecom(xor(type10Temp3,type10Temping3)) = longer(xor(type10Temp3,type10Temping3));
%randomUniformInitialPointOfRecom(xor(type11Temp3,type11Temping3)) = longer(xor(type11Temp3,type11Temping3));
%randomUniformInitialPointOfRecom(xor(type12Temp3,type12Temping3)) = longer(xor(type12Temp3,type12Temping3));
%for 11 and 12
type11Temping3 = and(type11,indexIniSmallerThanCoal2);
type12Temping3 = and(type12,indexIniSmallerThanCoal2);
type11Temp3 = and(type11Temping3,indexThatCoalBelowCoal2Temp3);
type12Temp3 = and(type12Temping3,indexThatCoalBelowCoal2Temp33);
longer(type11Temp3) = randomUniformInitialPointOfRecom(type11Temp3)+expRate1Temp1(type11Temp3);
longer(type12Temp3) = randomUniformInitialPointOfRecom(type12Temp3)+expRate1Temp2(type12Temp3);
randomUniformInitialPointOfRecom(xor(type9Temp3,type9Temping3)) = longer(xor(type9Temp3,type9Temping3));
randomUniformInitialPointOfRecom(xor(type10Temp3,type10Temping3)) = longer(xor(type10Temp3,type10Temping3));
randomUniformInitialPointOfRecom(xor(type11Temp3,type11Temping3)) = longer(xor(type11Temp3,type11Temping3));
randomUniformInitialPointOfRecom(xor(type12Temp3,type12Temping3)) = longer(xor(type12Temp3,type12Temping3));
% for type 13 to 16


type13Temping3 = and(type13,indexIniSmallerThanCoal2);
type14Temping3 = and(type14,indexIniSmallerThanCoal2);
type13Temp31 = and(type13Temping3,indexing221);
type13Temp32 = and(type13Temping3,indexing222);

type14Temp31 = and(type14Temping3,indexing221);
type14Temp32 = and(type14Temping3,indexing222);
initialGraphType(type13Temp31) = 2;
initialGraphType(type14Temp31) = 3;
type13Temp3 = or(type13Temp31,type13Temp32);
type14Temp3 = or(type14Temp31,type14Temp32);
shorter(type13Temp3) = randomUniformInitialPointOfRecom(type13Temp3)+expRate2Temp2(type13Temp3);
shorter(type14Temp3) = randomUniformInitialPointOfRecom(type14Temp3)+expRate2Temp2(type14Temp3);

%for 15 and 16
type15Temping3 = and(type15,indexIniSmallerThanCoal2);
type16Temping3 = and(type16,indexIniSmallerThanCoal2);
type15Temp3 = and(type15Temping3,indexThatCoalBelowCoal2Temp3);
type16Temp3 = and(type16Temping3,indexThatCoalBelowCoal2Temp33);
longer(type15Temp3) = randomUniformInitialPointOfRecom(type15Temp3)+expRate1Temp1(type15Temp3);
longer(type16Temp3) = randomUniformInitialPointOfRecom(type16Temp3)+expRate1Temp2(type16Temp3);
randomUniformInitialPointOfRecom(xor(type13Temp3,type13Temping3)) = longer(xor(type13Temp3,type13Temping3));
randomUniformInitialPointOfRecom(xor(type14Temp3,type14Temping3)) = longer(xor(type14Temp3,type14Temping3));
randomUniformInitialPointOfRecom(xor(type15Temp3,type15Temping3)) = longer(xor(type15Temp3,type15Temping3));
randomUniformInitialPointOfRecom(xor(type16Temp3,type16Temping3)) = longer(xor(type16Temp3,type16Temping3));
%start column4
indexFinal = ((randomUniformInitialPointOfRecom-longer) == 0);

%
type1Temp4 = and(type1,indexFinal);
shorter(type1Temp4) = longer(type1Temp4);
longer(type1Temp4) = randomUniformInitialPointOfRecom(type1Temp4) + expRate1Temp3(type1Temp4);
initialGraphType(type1Temp4) = 4;
type2Temp4 = and(type2,indexFinal);
shorter(type2Temp4) = longer(type2Temp4);
longer(type2Temp4) = randomUniformInitialPointOfRecom(type2Temp4) + expRate1Temp3(type2Temp4);
initialGraphType(type2Temp4) = 3;

type3Temp4 = and(type3,indexFinal);
longer(type3Temp4) = randomUniformInitialPointOfRecom(type3Temp4) + expRate1Temp2(type3Temp4);

type4Temp4 = and(type4,indexFinal);
longer(type4Temp4) = randomUniformInitialPointOfRecom(type4Temp4) + expRate1Temp2(type4Temp4);

type5Temp4 = and(type5,indexFinal);
shorter(type5Temp4) = longer(type5Temp4);
longer(type5Temp4) = randomUniformInitialPointOfRecom(type5Temp4) + expRate1Temp3(type5Temp4);
initialGraphType(type5Temp4) = 4;
type6Temp4 = and(type6,indexFinal);
shorter(type6Temp4) = longer(type6Temp4);
longer(type6Temp4) = randomUniformInitialPointOfRecom(type6Temp4) + expRate1Temp3(type6Temp4);
initialGraphType(type6Temp4) = 3;


type7Temp4 = and(type7,indexFinal);
longer(type7Temp4) = randomUniformInitialPointOfRecom(type7Temp4) + expRate1Temp2(type7Temp4);

type8Temp4 = and(type8,indexFinal);
longer(type8Temp4) = randomUniformInitialPointOfRecom(type8Temp4) + expRate1Temp2(type8Temp4);

type9Temp4 = and(type9,indexFinal);
shorter(type9Temp4) = longer(type9Temp4);
longer(type9Temp4) = randomUniformInitialPointOfRecom(type9Temp4) + expRate1Temp2(type9Temp4);
initialGraphType(type9Temp4) = 4;


type10Temp4 = and(type10,indexFinal);
shorter(type10Temp4) = longer(type10Temp4);
longer(type10Temp4) = randomUniformInitialPointOfRecom(type10Temp4) + expRate1Temp1(type10Temp4);
initialGraphType(type10Temp4) = 2;


type11Temp4 = and(type11,indexFinal);
longer(type11Temp4) = randomUniformInitialPointOfRecom(type11Temp4) + expRate1Temp2(type11Temp4);

type12Temp4 = and(type12,indexFinal);
longer(type12Temp4) = randomUniformInitialPointOfRecom(type12Temp4) + expRate1Temp2(type12Temp4);

type13Temp4 = and(type13,indexFinal);
shorter(type13Temp4) = longer(type13Temp4);
longer(type13Temp4) = randomUniformInitialPointOfRecom(type13Temp4) + expRate1Temp2(type13Temp4);
initialGraphType(type13Temp4) = 3;


type14Temp4 = and(type14,indexFinal);
shorter(type14Temp4) = longer(type14Temp4);
longer(type14Temp4) = randomUniformInitialPointOfRecom(type14Temp4) + expRate1Temp1(type14Temp4);
initialGraphType(type14Temp4) = 2;

type15Temp4 = and(type15,indexFinal);

longer(type15Temp4) = randomUniformInitialPointOfRecom(type15Temp4) + expRate1Temp2(type15Temp4);
type16Temp4 = and(type16,indexFinal);

longer(type16Temp4) = randomUniformInitialPointOfRecom(type16Temp4) + expRate1Temp2(type16Temp4);

% finish the updating (recomb) of all the gene

indexShorter1 = (initialGraphType == 1 | initialGraphType ==2 );

indexShorter2 = (initialGraphType == 3);
indexShorter3 = (initialGraphType == 4);
treeThatNotStop(indexShorter1,1) = newDis(shorter(indexShorter1),1);
treeThatNotStop(indexShorter1,2) = newDis(longer(indexShorter1),1);
treeThatNotStop(indexShorter1,3) = newDis(longer(indexShorter1),1);

treeThatNotStop(indexShorter2,2) = newDis(shorter(indexShorter2),1);
treeThatNotStop(indexShorter2,1) = newDis(longer(indexShorter2),1);
treeThatNotStop(indexShorter2,3) = newDis(longer(indexShorter2),1);

treeThatNotStop(indexShorter3,3) = newDis(shorter(indexShorter3),1);
treeThatNotStop(indexShorter3,1) = newDis(longer(indexShorter3),1);
treeThatNotStop(indexShorter3,2) = newDis(longer(indexShorter3),1);
if whileLoopIteration == input
temping111 = [temping111;treeThatNotStop];
end
%if whileLoopIteration == 6
%%%temping222 = treeThatNotStop;
%end
lengthTotal = 2*longer + shorter;
expOfTotalLength = random('exp', ((lengthTotal.^-1)/recomRate));
indexDone = ((sumOfTotalWeight+expOfTotalLength)>=1);
summingUp = sum(indexDone);
if summingUp > 0
tempInitial1 = times((1-sumOfTotalWeight(indexDone))',treeThatNotStop(indexDone,1));
tempInitial2 = times((1-sumOfTotalWeight(indexDone))',treeThatNotStop(indexDone,2));
tempInitial3 = times((1-sumOfTotalWeight(indexDone))',treeThatNotStop(indexDone,3));
tempInitial = [tempInitial1,tempInitial2,tempInitial3];
initialTree(numberIndexNotDoneIni(indexDone),:) = initialTree(numberIndexNotDoneIni(indexDone),:) + tempInitial;

end
%trying6 = initialGraphType;
%eachGraphType = [eachGraphType;initialGraphType,zeros(1,total-goal)];
expOfTotalLength(indexDone) = [];
sumOfTotalWeight(indexDone) =[];
sumOfTotalWeight = sumOfTotalWeight + expOfTotalLength;
initialGraphType(indexDone) = [];
goal = goal - summingUp;


numberIndexNotDoneIni(indexDone) = [];
treeThatNotStop(indexDone,:) = [];
tempInitial4 = times(expOfTotalLength',treeThatNotStop(:,1));
tempInitial5 = times(expOfTotalLength',treeThatNotStop(:,2));
tempInitial6= times(expOfTotalLength',treeThatNotStop(:,3));
shorter(indexDone) = [];
longer(indexDone) = [];
totalLengthOfTheInitial= 2*longer+shorter;
initialTree(numberIndexNotDoneIni,:) = initialTree(numberIndexNotDoneIni,:) + [tempInitial4,tempInitial5,tempInitial6];

whileLoopIteration = whileLoopIteration+1;

if whileLoopIteration == 1000000000000000000
goal =0;
end



%indexing13 = ((randomUni+expRate1Temp3-longer)<0);
%indexing21 = ((randomUni+expRate2Temp1-shorter)<0);
%indexing22 = ((randomUni+expRate2Temp2-longer)<0);
%indexTemp1 = or(indexing11,indexing12);
%indexing1and1 = xor(indexTemp1,indexing12);
%indexTemp2 = or(indexTemp1,index22);
%indexing1and1and2 = xor(indexTemp2,indexTemp1);

%indexTemp3 = or(indexing11,indexing21);
%index1and2 = xor(indexTemp3,indexing11);
%indexTemp4 = or(indexTemp3,indexing22);
%indexing1and2and2 = xor(indexTemp4,indexingTemp3);
%indexTemp5 = or(indexTemp3,indexing13);
%indexing1and2and1 = xor(indexTemp5,indexingTemp3);

%indexTemp6 = or(indexing21,indexing13);
%indexing0and2and1 = xor(indexTemp6,indexing21);
%indexing0and2and2 = xor(or(indexing21,indexing22),indexing21);


end
disTree = initialTree;
indexx = whileLoopIteration;
pos = eachGraphType;
trying = initialStayTry;
trying111 = temping111;
%trying222 = temping222;
end
