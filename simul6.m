function geneDisTree = simul6(div1,div2,numGene,simulTime)
height = div1 - div2;
numGene = round(numGene);
exp1s = random('exp', 1, [2, numGene*simulTime]);


exp1 = exp1s(1,:);
exp1Star = (exp1s(2,:));


I = (exp1 < height);
sizeI = sum(I);
sizeNotI = numGene*simulTime - sizeI;

indexNotI = find(exp1 >= height);
temp1 = zeros(1,numGene*simulTime);
temp2 = zeros(1,numGene*simulTime);
temp3 = zeros(1,numGene*simulTime);
temp1(I) = exp1(I) + div2;
temp2(I) = exp1Star(I)+ div1;
temp3(I) = temp2(I);





unif = random('Discrete Uniform', 3, [1, sizeNotI]);
exp3 = random('exp', 1/3, [1, sizeNotI]);

index11 = (unif == 1);
index21 = (unif == 2);
index31 = (unif == 3);
index1 = indexNotI(index11);
index2 = indexNotI(index21);
index3 = indexNotI(index31);

temp1(index1) = exp3(index11) + div1;
temp2(index1) = exp3(index11) + exp1Star(index11) + div1;
temp3(index1) = temp2(index1);
temp1(index2) = exp3(index21) + exp1Star(index21) + div1;
temp2(index2) = exp3(index21) + div1;
temp3(index2) = temp1(index2);
temp1(index3) = exp3(index31) + exp1Star(index31) + div1;
temp2(index3) = temp1(index3);
temp3(index3) = exp3(index31) + div1;

%column1 = [temp1,temp11,temp12,temp13];
%column2 = [temp2,temp21,temp22,temp23];
%column3 = [temp3,temp31,temp32,temp33];

tempGeneDisTree = [temp1',temp2',temp3'];
%tempingGeneDisTree = cat(3,ones(numGene,3),ones(numGene,3));
%for j = 1 : simulTime
%    
 %   tempingGeneDisTree(:,:,j) = tempGeneDisTree((1+(j-1)*numGene):(j*numGene),:);
%end
geneDisTree = tempGeneDisTree;
end
