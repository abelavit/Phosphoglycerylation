
load Filtered_Training
load Testing

Whole_Test = {'Fold1_10' 'Fold2_10' 'Fold3_10' 'Fold4_10' 'Fold5_10' 'Fold6_10' 'Fold7_10' 'Fold8_10' 'Fold9_10' 'Fold10_10'}; 
Whole_Train = {'Train1' 'Train2' 'Train3' 'Train4' 'Train5' 'Train6' 'Train7' 'Train8' 'Train9' 'Train10'}; 

for i = 1:10

    st = num2str(i);
    test_name = strcat('Fold', st, '_10');
    train_name = strcat('Train', st);
    
    % Prepare the train, test, train label and test label sets
    Test_Data = [eval(test_name)];
    Train_Data = [eval(train_name)];
    
    Test = cell2mat(Test_Data(:,2));
    Train = cell2mat(Train_Data(:,2));

    test_label = cell2mat(Test_Data(:,3));
    train_label = cell2mat(Train_Data(:,3));
    Test_label = str2num(test_label);
    Train_label = str2num(train_label);

    % Train LibSVM-weights. Empty square brackets denote we are not
    % supplying weights
    model=svmtrain([],Train_label,Train,['-s 0 -t 1 -c 1000 -g 1000']);
    
    % Test the classifier
    [pred,acc,prob_values]=svmpredict(Test_label,Test,model);
    
    % Save the predicted labels and the true labels
    prediction{i} = pred;
    True_label{i} = Test_label;

    % Obtaining the FN, FP, TN and TP values
    FN = 0;
    FP = 0;
    TN = 0;
    TP = 0;
    for j = 1:size(Test_label,1)
        if Test_label(j) == 1
            if pred(j) == 1
                TP = TP + 1;
            else
                FN = FN + 1; 
            end
        else
            if pred(j) == 1
                FP = FP + 1;
            else
                TN = TN + 1; 
            end
        end
    end
    
    % Calculating the performance metrics
    sen = TP/(TP+FN);
    spe = TN/(TN+FP);
    pre = TP/(TP+FP);
    accuracy = (TN+TP)/(FN+FP+TN+TP);
    mcc = ((TN*TP)-(FN*FP))/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
    Results(1,i) = sen; 
    Results(2,i) = spe; 
    Results(3,i) = pre; 
    Results(4,i) = accuracy; 
    Results(5,i) = mcc;
end
Results_Avg = sum(Results,2)/10; % 10 fold CV result 

% AUC calculation and ROC plot
classes = [True_label{1}; True_label{2}; True_label{3}; True_label{4}; True_label{5}; True_label{6}; True_label{7}; True_label{8}; True_label{9}; True_label{10}];
scores = [prediction{1}; prediction{2}; prediction{3}; prediction{4}; prediction{5}; prediction{6}; prediction{7}; prediction{8}; prediction{9}; prediction{10}];

classes = [True_label{1}; True_label{2}; True_label{3}; True_label{4}; True_label{5}; True_label{6}; True_label{7}; True_label{8}; True_label{9}; True_label{10}];
scores = [prediction{1}; prediction{2}; prediction{3}; prediction{4}; prediction{5}; prediction{6}; prediction{7}; prediction{8}; prediction{9}; prediction{10}];

[X,Y,T,AUC] = perfcurve(classes,scores,1);

metrics = {'sensitivity'; 'specificity'; 'precision'; 'accuracy'; 'mcc'};
Ten_Fold_CV = [metrics, num2cell(Results_Avg)] 
AUC

clear all; 