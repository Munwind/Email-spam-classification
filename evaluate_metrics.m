
function [precision, recall, f1_score] = evaluate_metrics(predicted, actual)
    TP = sum((predicted == 1) & (actual == 1));
    FP = sum((predicted == 1) & (actual == 0));
    FN = sum((predicted == 0) & (actual == 1));
    precision = TP / (TP + FP);
    recall = TP / (TP + FN);
    f1_score = 2 * (precision * recall) / (precision + recall);
end