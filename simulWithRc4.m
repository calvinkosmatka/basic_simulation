function [disTree,indexx] = simulWithRc4(div1,div2,numGene,recomRate,simulTime)
initialTree = simul6(div1,div2,numGene,simulTime);
total = numGene*simulTime;
initialTree2 = initialTree';
[shorter,initialPos] = min(initialTree2);
longer = max(initialTree2);
temp1 = shorter - div2;
temp2 = find(temp1>=0);
initialPos(temp2) = initialPos (temp2) +1;

%goal = ones(1,numGene);
initialTotal = (sum(initialTree,2))';
expTotal = random('exp',( (initialTotal.^-1)/recomRate));
%index1 = find(expTotal >= 1);
%num = 11; % need to fix 
index = 0;

indexingIni = (expTotal>=1);
tempSize = sum(indexingIni);
indexingNotDoneIni = find(expTotal<1);
%logicalNotDoneIni = (expTotal<1);
tempNotDoneSize = total-tempSize;
fraction = zeros(1,tempNotDoneSize);


longer(indexingIni) = [];
shorter(indexingIni) = [];
initialPos(indexingIni) = [];
expTotal(indexingIni) = 1;

initialTree = [times(expTotal',initialTree(:,1)),times(expTotal',initialTree(:,2)),times(expTotal',initialTree(:,3))];
goal = tempNotDoneSize;
initialTreeTemp = zeros(goal,3);
initialTotal(indexingIni) = [];
expTotal(indexingIni) = [];
fraction = fraction + expTotal;

while goal > 0
%generate al the random numbers here

uniformCoal = random('Discrete Uniform',2,[2, goal]);
expRate1 = random('exp',1,[3,goal]);
expRate2 = random('exp',1/2,[2,goal]);
expRate1Temp1 = expRate1(1,:);
expRate2Temp1 = expRate2(1,:);
uniformCoalTemp1 = uniformCoal(1,:);
expRate1Temp2 = expRate1(2,:);
expRate2Temp2 = expRate2(2,:);
uniformCoalTemp2 = uniformCoal(2,:);
expRate1Temp3 = expRate1(3,:);


%random Initial Postion
randomUni = random('uniform',0,initialTotal);
randomUni1 = randomUni - div2;
randomUni2 = randomUni - div2*2;
randomUni3 = randomUni - div2 - div1;
randomUni4 = randomUni - div2-2*div1;



indexBranchTwo = (randomUni2 < 0 & randomUni2 >= -div2);
indexBranchThree = (randomUni3 < 0 & randomUni3 >= -2*div2);
indexBranchFour = (randomUni4 >= (-div1-div2));
randomUni(indexBranchTwo) = randomUni(indexBranchTwo) - div2;
randomUni(indexBranchThree) = randomUni(indexBranchThree) - div2;
randomUni(indexBranchFour) = randomUni(indexBranchFour) - div2-div1;
indexIniSmallerThanDiv2 = (randomUni < div2);
randomUni(indexIniSmallerThanDiv2)= div2;
indexIniSmallerThanDiv1 = (randomUni < div1);

indexIniSmallerThanCoal1 = ((randomUni-shorter) < 0);
type1 = (initialPos == 1 & randomUni1<0);
type2 = (initialPos == 1 & randomUni2 < 0 & randomUni1 >=0);
type3 = (initialPos == 1 & randomUni3 < 0 & randomUni2 >=0);
type4 = (initialPos == 1 & randomUni4 < 0 & randomUni3 >=0);
type5 = (initialPos == 2 & randomUni1<0);
type6 = (initialPos == 2 & randomUni2 < 0 & randomUni1 >=0);
type7 = (initialPos == 2 & randomUni3 < 0 & randomUni2 >=0);
type8 = (initialPos == 2 & randomUni4 < 0 & randomUni3 >=0);
type9 = (initialPos == 3 & randomUni1<0);
type10 = (initialPos == 3 & randomUni2 < 0 & randomUni1 >=0);
type11 = (initialPos == 3 & randomUni3 < 0 & randomUni2 >=0);
type12 = (initialPos == 3 & randomUni4 < 0 & randomUni3 >=0);
type13 = (initialPos == 4 & randomUni1<0);
type14 = (initialPos == 4 & randomUni2 < 0 & randomUni1 >=0);
type15 = (initialPos == 4 & randomUni3 < 0 & randomUni2 >=0);
type16 = (initialPos == 4 & randomUni4 < 0 & randomUni3 >=0);

indexingUni11 = (uniformCoalTemp1 == 1);
indexingUni12 = (uniformCoalTemp1 == 2);
indexingUni21 = (uniformCoalTemp2 == 1);
indexingUni22 = (uniformCoalTemp2 == 2);


indexing11 = ((randomUni+expRate1Temp1-div1)<0);
indexing12 = ((randomUni+expRate1Temp1-shorter)<0);
%begin the first column of the matrix
%for type 1 to 4 (3,4 rate 0, ignore)(same condition as column2, combine)
type1Temping1 = and(type1,indexIniSmallerThanCoal1);
type2Temping1 = and(type2,indexIniSmallerThanCoal1);

type1Temp1 = and(type1Temping1,indexing12);
type2Temp1 = and(type2Temping1,indexing12);

shorter(type1Temp1) = randomUni(type1Temp1) + expRate1Temp1(type1Temp1);
shorter(type2Temp1) = randomUni(type2Temp1) + expRate1Temp1(type2Temp1);
randomUni(xor(type1Temping1,type1Temp1)) = shorter(xor(type1Temping1,type1Temp1));
randomUni(xor(type2Temping1,type2Temp1)) = shorter(xor(type2Temping1,type2Temp1));
%for type 5 to 8 (ignore type 7 and 8)
type5Temping1 = and(type5,indexIniSmallerThanDiv1);
type6Temping1 = and(type6,indexIniSmallerThanDiv1);
type5Temp1 = and(type5Temping1,indexing11);
type6Temp1 = and(type6Temping1,indexing11);
shorter(type5Temp1) = randomUni(type5Temp1) + expRate1Temp1(type5Temp1);
shorter(type6Temp1) = randomUni(type6Temp1) + expRate1Temp1(type6Temp1);
randomUni(xor(type5Temping1,type5Temp1)) = div1;
randomUni(xor(type6Temping1,type6Temp1)) = div1;
initialPos(type5Temp1) =1;
initialPos(type6Temp1) =1;
%for type 9 to 12 (ignore type10,11)
type9Temping1 = and(type9,indexIniSmallerThanDiv1);
type12Temping1 = and(type12,indexIniSmallerThanDiv1);
type9Temp1 = and(type9Temping1,indexing11);
type12Temp1 = and(type12Temping1,indexing11);
shorter(type9Temp1) = randomUni(type9Temp1) + expRate1Temp1(type9Temp1);
longer(type12Temp1) = shorter(type12Temp1);
shorter(type12Temp1) = randomUni(type12Temp1) + expRate1Temp1(type12Temp1);
randomUni(xor(type9Temping1,type9Temp1)) = div1;
randomUni(xor(type12Temping1,type12Temp1)) = div1;
initialPos(type9Temp1) =1;
initialPos(type12Temp1) =1;
%for type 13 to 16 (ignore type 14.15)
type13Temping1 = and(type9,indexIniSmallerThanDiv1);
type16Temping1 = and(type12,indexIniSmallerThanDiv1);
type13Temp1 = and(type13Temping1,indexing11);
type16Temp1 = and(type16Temping1,indexing11);
shorter(type13Temp1) = randomUni(type13Temp1) + expRate1Temp1(type13Temp1);
longer(type16Temp1) = shorter(type16Temp1);
shorter(type16Temp1) = randomUni(type16Temp1) + expRate1Temp1(type16Temp1);
randomUni(xor(type13Temping1,type13Temp1)) = div1;
randomUni(xor(type16Temping1,type16Temp1)) = div1;
initialPos(type13Temp1) =1;
initialPos(type16Temp1) =1;
% start the column2,
indexIniSmallerThanCoal1 = ((randomUni-shorter) < 0 & randomUni >= div1 );
indexIniSmallerThanDiv1 = ((randomUni-shorter) >= 0 & randomUni < div1 );
indexing12 = ((randomUni+expRate2Temp2-shorter)<0);
indexing21 = ((randomUni+expRate2Temp1-shorter)<0);
indexing211 = and(indexing21,indexingUni11);
indexing212 = and(indexing21,indexingUni12);
%type 1 to 4, ingore 3,4, 
% 1,2 are combined 
type1Temping2 = and(type1,indexIniSmallerThanDiv1);
type2Temping2 = and(type2,indexIniSmallerThanDiv1);

type1Temp2 = and(type1Temping2,indexing12);
type2Temp2 = and(type2Temping2,indexing12);

shorter(type1Temp2) = randomUni(type1Temp2) + expRate1Temp1(type1Temp2);
shorter(type2Temp2) = randomUni(type2Temp2) + expRate1Temp1(type2Temp2);
randomUni(xor(type1Temping2,type1Temp2)) = div1;
randomUni(xor(type2Temping2,type2Temp2)) = div1;
% for type 5 to 8, ignore type 7
type5Temping2 = and(type5,indexIniSmallerThanCoal1);
type6Temping2 = and(type6,indexIniSmallerThanCoal1);
type5Temp21 = and(type5Temping2,indexing211);
type5Temp22 = and(type5Temping2,indexing212);
type6Temp21 = and(type6Temping2,indexing211);
type6Temp22 = and(type6Temping2,indexing212);
shorter(type5Temp21) = expRate2Temp1(type5Temp21) + randomUni(type5Temp21);
shorter(type5Temp22) = expRate2Temp1(type5Temp22) + randomUni(type5Temp22);
initialPos(type5Temp22) = 3;


shorter(type6Temp21) = expRate2Temp1(type6Temp21) + randomUni(type6Temp21);
shorter(type6Temp22) = expRate2Temp1(type6Temp22) + randomUni(type6Temp22);
initialPos(type6Temp22) = 4;

type8Temping2 = and(type8,indexIniSmallerThanCoal1);
type8Temp21 = and(type8Temping2,indexing211);
type8Temp22 = and(type8Temping2,indexing212);

shorter(type8Temp21) = expRate2Temp1(type8Temp21) + randomUni(type8Temp21);
shorter(type8Temp22) = expRate2Temp1(type8Temp22) + randomUni(type8Temp22);
initialPos(type8Temp21) = 3;
initialPos(type8Temp22) = 4;
type5Temp2 = or(type5Temp21,type5Temp22);
type6Temp2 = or(type6Temp21,type6Temp22);
type8Temp2 = or(type8Temp21,type8Temp22);
randomUni(xor(type5Temp2,type5Temping2)) = shorter(xor(type5Temp2,type5Temping2));
randomUni(xor(type6Temp2,type6Temping2)) = shorter(xor(type6Temp2,type6Temping2));
randomUni(xor(type8Temp2,type8Temping2)) = shorter(xor(type8Temp2,type8Temping2));

% for type 9 to 12,ignore 11

type9Temping2 = and(type9,indexIniSmallerThanCoal1);
type10Temping2 = and(type10,indexIniSmallerThanCoal1);
type9Temp21 = and(type9Temping2,indexing211);
type9Temp22 = and(type9Temping2,indexing212);
type10Temp21 = and(type10Temping2,indexing211);
type10Temp22 = and(type10Temping2,indexing212);
shorter(type9Temp21) = expRate2Temp1(type9Temp21) + randomUni(type9Temp21);
shorter(type9Temp22) = expRate2Temp1(type9Temp22) + randomUni(type9Temp22);
initialPos(type9Temp21) = 2;


shorter(type10Temp21) = expRate2Temp1(type10Temp21) + randomUni(type10Temp21);
shorter(type10Temp22) = expRate2Temp1(type10Temp22) + randomUni(type10Temp22);
initialPos(type10Temp22) = 4;

type12Temping2 = and(type12,indexIniSmallerThanCoal1);
type12Temp21 = and(type12Temping2,indexing211);
type12Temp22 = and(type12Temping2,indexing212);
longer(type12Temp21)=shorter(type12Temp21);
longer(type12Temp22)=shorter(type12Temp22);
shorter(type12Temp21) = expRate2Temp1(type12Temp21) + randomUni(type12Temp21);
shorter(type12Temp22) = expRate2Temp1(type12Temp22) + randomUni(type12Temp22);
initialPos(type12Temp21) = 2;
initialPos(type12Temp22) = 4;
type9Temp2 = or(type9Temp21,type9Temp22);
type10Temp2 = or(type10Temp21,type10Temp22);
type12Temp2 = or(type12Temp21,type12Temp22);
randomUni(xor(type9Temp2,type9Temping2)) = shorter(xor(type9Temp2,type9Temping2));
randomUni(xor(type10Temp2,type10Temping2)) = shorter(xor(type10Temp2,type10Temping2));
randomUni(xor(type12Temp2,type12Temping2)) = shorter(xor(type12Temp2,type12Temping2));

%for type13 to 16, ignore 15
type13Temping2 = and(type13,indexIniSmallerThanCoal1);
type14Temping2 = and(type14,indexIniSmallerThanCoal1);
type13Temp21 = and(type13Temping2,indexing211);
type13Temp22 = and(type13Temping2,indexing212);
type14Temp21 = and(type14Temping2,indexing211);
type14Temp22 = and(type14Temping2,indexing212);
shorter(type13Temp21) = expRate2Temp1(type13Temp21) + randomUni(type13Temp21);
shorter(type13Temp22) = expRate2Temp1(type13Temp22) + randomUni(type13Temp22);
initialPos(type13Temp21) = 2;


shorter(type14Temp21) = expRate2Temp1(type14Temp21) + randomUni(type14Temp21);
shorter(type14Temp22) = expRate2Temp1(type14Temp22) + randomUni(type14Temp22);
initialPos(type14Temp21) = 3;

type16Temping2 = and(type16,indexIniSmallerThanCoal1);
type16Temp21 = and(type16Temping2,indexing211);
type16Temp22 = and(type16Temping2,indexing212);
longer(type16Temp21)=shorter(type16Temp21);
longer(type16Temp22)=shorter(type16Temp22);
shorter(type16Temp21) = expRate2Temp1(type16Temp21) + randomUni(type16Temp21);
shorter(type16Temp22) = expRate2Temp1(type16Temp22) + randomUni(type16Temp22);
initialPos(type16Temp21) = 2;
initialPos(type16Temp22) = 3;
type13Temp2 = or(type13Temp21,type13Temp22);
type14Temp2 = or(type14Temp21,type14Temp22);
type16Temp2 = or(type16Temp21,type16Temp22);
randomUni(xor(type13Temp2,type13Temping2)) = shorter(xor(type13Temp2,type13Temping2));
randomUni(xor(type14Temp2,type14Temping2)) = shorter(xor(type14Temp2,type14Temping2));
randomUni(xor(type16Temp2,type16Temping2)) = shorter(xor(type16Temp2,type16Temping2));

% start column3
indexIniSmallerThanCoal2 = ((randomUni-longer) < 0 & (randomUni-shorter) >= 0);
indexing21 = ((randomUni+expRate2Temp1-longer)<0);
indexing211 = and(indexing21,indexingUni11);
indexing212 = and(indexing21,indexingUni12);
indexing11 = ((randomUni+expRate1Temp1-longer)<0);
indexing12 = ((randomUni+expRate1Temp2-longer)<0);
indexing22 = ((randomUni+expRate2Temp2-longer)<0);
indexing221 = and(indexing22,indexingUni21);
indexing222 = and(indexing22,indexingUni22);

%for type 1 to 4
type1Temping3 = and(type1,indexIniSmallerThanCoal2);
type2Temping3 = and(type2,indexIniSmallerThanCoal2);
type1Temp31 = and(type1Temping3,indexing211);
type1Temp32 = and(type1Temping3,indexing212);
type2Temp31 = and(type2Temping3,indexing211);
type2Temp32 = and(type2Temping3,indexing212);
initialPos(type1Temp31) = 2;
initialPos(type1Temp32) = 3;
initialPos(type2Temp31) = 2;
initialPos(type2Temp32) = 4;
type1Temp3 = or(type1Temp31,type1Temp32);
type2Temp3 = or(type2Temp31,type2Temp32);
shorter(type1Temp3) = randomUni(type1Temp3)+expRate2Temp1(type1Temp3);
shorter(type2Temp3) = randomUni(type2Temp3)+expRate2Temp1(type2Temp3);
type3Temping3 = and(type3,indexIniSmallerThanCoal2);
type4Temping3 = and(type4,indexIniSmallerThanCoal2);
type3Temp3 = and(type3Temping3,indexing11);
type4Temp3 = and(type4Temping3,indexing11);
longer(type3Temp3) = randomUni(type3Temp3)+expRate1Temp1(type3Temp3);
longer(type4Temp3) = randomUni(type4Temp3)+expRate1Temp1(type4Temp3);




randomUni(xor(type1Temp3,type1Temping3)) = longer(xor(type1Temp3,type1Temping3));
randomUni(xor(type2Temp3,type2Temping3)) = longer(xor(type2Temp3,type2Temping3));
randomUni(xor(type3Temp3,type3Temping3)) = longer(xor(type3Temp3,type3Temping3));
randomUni(xor(type4Temp3,type4Temping3)) = longer(xor(type4Temp3,type4Temping3));

% for type 5 to 8
type5Temping3 = and(type5,indexIniSmallerThanCoal2);
type6Temping3 = and(type6,indexIniSmallerThanCoal2);
type5Temp31 = and(type5Temping3,indexing221);
type5Temp32 = and(type5Temping3,indexing222);
type6Temp31 = and(type6Temping3,indexing221);
type6Temp32 = and(type6Temping3,indexing222);
type5Temp3 = or(type5Temp31,type5Temp32);
type6Temp3 = or(type6Temp31,type6Temp32);
initialPos(type5Temp32) = 3;

initialPos(type6Temp32) = 4;
shorter(type5Temp3) = randomUni(type5Temp3)+expRate2Temp2(type5Temp3);
shorter(type6Temp3) = randomUni(type6Temp3)+expRate2Temp2(type6Temp3);

type7Temping3 = and(type7,indexIniSmallerThanCoal2);
type8Temping3 = and(type8,indexIniSmallerThanCoal2);
type7Temp3 = and(type7Temping3,indexing11);
type8Temp3 = and(type8Temping3,indexing11);
longer(type7Temp3) = randomUni(type7Temp3)+expRate1Temp1(type7Temp3);
longer(type8Temp3) = randomUni(type8Temp3)+expRate1Temp1(type8Temp3);



randomUni(xor(type5Temp3,type5Temping3)) = longer(xor(type5Temp3,type5Temping3));
randomUni(xor(type6Temp3,type6Temping3)) = longer(xor(type6Temp3,type6Temping3));
randomUni(xor(type7Temp3,type7Temping3)) = longer(xor(type7Temp3,type7Temping3));
randomUni(xor(type8Temp3,type8Temping3)) = longer(xor(type8Temp3,type8Temping3));

% for type 9 to 12

type9Temping3 = and(type9,indexIniSmallerThanCoal2);
type10Temping3 = and(type10,indexIniSmallerThanCoal2);
type9Temp31 = and(type9Temping3,indexing221);
type9Temp32 = and(type5Temping3,indexing222);
type10Temp31 = and(type6Temping3,indexing221);
type10Temp32 = and(type10Temping3,indexing222);

initialPos(type9Temp31) = 2;
initialPos(type10Temp32) = 4;
type9Temp3 = or(type9Temp31,type9Temp32);
type10Temp3 = or(type10Temp31,type10Temp32);
shorter(type9Temp3) = randomUni(type9Temp3)+expRate2Temp2(type9Temp3);
shorter(type10Temp3) = randomUni(type10Temp3)+expRate2Temp2(type10Temp3);

%for 11 and 12
type11Temping3 = and(type11,indexIniSmallerThanCoal2);
type12Temping3 = and(type12,indexIniSmallerThanCoal2);
type11Temp3 = and(type11Temping3,indexing11);
type12Temp3 = and(type12Temping3,indexing12);
longer(type11Temp3) = randomUni(type11Temp3)+expRate1Temp1(type11Temp3);
longer(type12Temp3) = randomUni(type12Temp3)+expRate1Temp2(type12Temp3);

randomUni(xor(type9Temp3,type9Temping3)) = longer(xor(type9Temp3,type9Temping3));
randomUni(xor(type10Temp3,type10Temping3)) = longer(xor(type10Temp3,type10Temping3));
randomUni(xor(type11Temp3,type11Temping3)) = longer(xor(type11Temp3,type11Temping3));
randomUni(xor(type12Temp3,type12Temping3)) = longer(xor(type12Temp3,type12Temping3));
% for type 13 to 16


type13Temping3 = and(type13,indexIniSmallerThanCoal2);
type14Temping3 = and(type14,indexIniSmallerThanCoal2);
type13Temp31 = and(type13Temping3,indexing221);
type13Temp32 = and(type13Temping3,indexing222);

type14Temp31 = and(type14Temping3,indexing221);
type14Temp32 = and(type14Temping3,indexing222);
initialPos(type13Temp31) = 2;
initialPos(type14Temp31) = 3;
type13Temp3 = or(type13Temp31,type13Temp32);
type14Temp3 = or(type14Temp31,type14Temp32);
shorter(type13Temp3) = randomUni(type13Temp3)+expRate2Temp2(type13Temp3);
shorter(type14Temp3) = randomUni(type14Temp3)+expRate2Temp2(type14Temp3);

%for 15 and 16
type15Temping3 = and(type15,indexIniSmallerThanCoal2);
type16Temping3 = and(type16,indexIniSmallerThanCoal2);
type15Temp3 = and(type15Temping3,indexing11);
type16Temp3 = and(type16Temping3,indexing12);
longer(type15Temp3) = randomUni(type15Temp3)+expRate1Temp1(type15Temp3);
longer(type16Temp3) = randomUni(type16Temp3)+expRate1Temp2(type16Temp3);
randomUni(xor(type13Temp3,type13Temping3)) = longer(xor(type13Temp3,type13Temping3));
randomUni(xor(type14Temp3,type14Temping3)) = longer(xor(type14Temp3,type14Temping3));
randomUni(xor(type15Temp3,type15Temping3)) = longer(xor(type15Temp3,type15Temping3));
randomUni(xor(type16Temp3,type16Temping3)) = longer(xor(type16Temp3,type16Temping3));

%start column4
indexFinal = ((randomUni-longer) >= 0);
%
type1Temp4 = and(type1,indexFinal);
shorter(type1Temp4) = longer(type1Temp4);
longer(type1Temp4) = randomUni(type1Temp4) + expRate1Temp3(type1Temp4);
initialPos(type1Temp4) = 4;
type2Temp4 = and(type2,indexFinal);
shorter(type2Temp4) = longer(type2Temp4);
longer(type2Temp4) = randomUni(type2Temp4) + expRate1Temp3(type2Temp4);
initialPos(type2Temp4) = 3;

type3Temp4 = and(type3,indexFinal);
longer(type3Temp4) = randomUni(type3Temp4) + expRate1Temp2(type3Temp4);

type4Temp4 = and(type4,indexFinal);
longer(type4Temp4) = randomUni(type4Temp4) + expRate1Temp2(type4Temp4);

type5Temp4 = and(type5,indexFinal);
shorter(type5Temp4) = longer(type5Temp4);
longer(type5Temp4) = randomUni(type5Temp4) + expRate1Temp3(type5Temp4);
initialPos(type5Temp4) = 4;

type6Temp4 = and(type6,indexFinal);
shorter(type6Temp4) = longer(type6Temp4);
longer(type6Temp4) = randomUni(type6Temp4) + expRate1Temp3(type6Temp4);
initialPos(type6Temp4) = 3;


type7Temp4 = and(type7,indexFinal);
longer(type7Temp4) = randomUni(type7Temp4) + expRate1Temp2(type7Temp4);

type8Temp4 = and(type8,indexFinal);
longer(type8Temp4) = randomUni(type8Temp4) + expRate1Temp2(type8Temp4);

type9Temp4 = and(type9,indexFinal);
shorter(type9Temp4) = longer(type9Temp4);
longer(type9Temp4) = randomUni(type9Temp4) + expRate1Temp2(type9Temp4);
initialPos(type9Temp4) = 4;


type10Temp4 = and(type10,indexFinal);
shorter(type10Temp4) = longer(type10Temp4);
longer(type10Temp4) = randomUni(type10Temp4) + expRate1Temp1(type10Temp4);
initialPos(type10Temp4) = 2;


type11Temp4 = and(type11,indexFinal);
longer(type11Temp4) = randomUni(type11Temp4) + expRate1Temp2(type11Temp4);

type12Temp4 = and(type12,indexFinal);
longer(type12Temp4) = randomUni(type12Temp4) + expRate1Temp2(type12Temp4);

type13Temp4 = and(type13,indexFinal);
shorter(type13Temp4) = longer(type13Temp4);
longer(type13Temp4) = randomUni(type13Temp4) + expRate1Temp2(type13Temp4);
initialPos(type13Temp4) = 3;


type14Temp4 = and(type14,indexFinal);
shorter(type14Temp4) = longer(type14Temp4);
longer(type14Temp4) = randomUni(type14Temp4) + expRate1Temp1(type14Temp4);
initialPos(type14Temp4) = 2;

type15Temp4 = and(type15,indexFinal);

longer(type15Temp4) = randomUni(type15Temp4) + expRate1Temp2(type15Temp4);
type16Temp4 = and(type16,indexFinal);

longer(type16Temp4) = randomUni(type16Temp4) + expRate1Temp2(type16Temp4);

% finish the updating (recomb) of all the gene

indexShorter1 = (initialPos == 1 | initialPos ==2 );

indexShorter2 = (initialPos == 3);
indexShorter3 = (initialPos == 4);
initialTreeTemp(indexShorter1,1) = shorter(indexShorter1);
initialTreeTemp(indexShorter1,2) = longer(indexShorter1);
initialTreeTemp(indexShorter1,3) = longer(indexShorter1);

initialTreeTemp(indexShorter2,2) = shorter(indexShorter2);
initialTreeTemp(indexShorter2,1) = longer(indexShorter2);
initialTreeTemp(indexShorter2,3) = longer(indexShorter2);

initialTreeTemp(indexShorter3,3) = shorter(indexShorter3);
initialTreeTemp(indexShorter3,1) = longer(indexShorter3);
initialTreeTemp(indexShorter3,2) = longer(indexShorter3);

lengthTotal = 2*longer + shorter;
expTotal = random('exp', ((lengthTotal.^-1)/recomRate));
indexDone = ((fraction+expTotal)>=1);
summingUp = sum(indexDone);
if summingUp > 0
tempInitial1 = times((1-fraction(indexDone))',initialTreeTemp(indexDone,1));
tempInitial2 = times((1-fraction(indexDone))',initialTreeTemp(indexDone,2));
tempInitial3 = times((1-fraction(indexDone))',initialTreeTemp(indexDone,3));
tempInitial = [tempInitial1,tempInitial2,tempInitial3];
initialTree(indexingNotDoneIni(indexDone),:) = initialTree(indexingNotDoneIni(indexDone),:) + tempInitial;

end
expTotal(indexDone) = [];
fraction(indexDone) =[];
fraction = fraction + expTotal;

initialPos(indexDone) = [];
goal = goal - summingUp;

initialTotal(indexDone) = [];
indexingNotDoneIni(indexDone) = [];
initialTreeTemp(indexDone,:) = [];
tempInitial4 = times(expTotal',initialTreeTemp(:,1));
tempInitial5 = times(expTotal',initialTreeTemp(:,2));
tempInitial6= times(expTotal',initialTreeTemp(:,3));
shorter(indexDone) = [];
longer(indexDone) = [];
initialTree(indexingNotDoneIni,:) = initialTree(indexingNotDoneIni,:) + [tempInitial4,tempInitial5,tempInitial6];

index = index+1;
if index == 100
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
indexx = index;
end