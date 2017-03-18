function [] = plot_rel_occ(A, B, i)

[f1, n1] = histcounts(A(:,i));
[f2, n2] = histcounts(B(:,i), n1);
f3 = f2./f1;

x = (n1(1)+n1(2))/2 : n1(2)-n1(1): (n1(length(n1)-1)+n1(length(n1)))/2;

bar(x, f3);

end