clc; clear all; close all;

mkdir plots;

Res = load('result.txt');
figure(1);

for i = 1:5:61
    for j = 0:1:1
        v = [(i-1)*6 + j*15 + 1 : (i-1)*6 + (j+1)*15];
        plot(Res(v,3), Res(v,5), 'b.', Res(v,3), Res(v,6), 'r*');
        hold on;
        plot([0 1500], [80 80]);
        str = strcat('Hidden Layer Size = ', num2str(i), ' Lambda = ', (num2str(j)));
        title(str);
        xlabel('Step')
        ylabel('Accuracy')
        ylim([65 90]);
        %   pause(0.5);
        str = strcat('plots\accuracy_', num2str(i) ,'_', num2str(j), '.png');
        saveas(gcf, str);
        hold off;
    end
end