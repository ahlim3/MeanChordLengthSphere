function SphereMCL (n, radius)
radius = 1;
x0 = -radius;
y0 = 0;
z0 = 0;
chordL = 0;
mclArray = [];
x0Array = [];
x1Array = [];
y0Array = [];
y1Array = [];
z0Array = [];
z1Array = [];
k = 10;
q = n / k;
volume = 4/3 * pi *radius^3;
surfacearea = 4 * pi *radius^2;
analyticalsolution = volume/surfacearea * 4
for z = 1 : n
    [x0, y0, z0] = SphereGenerator(radius);
    [x1,y1,z1] = SphereGenerator(radius);
    chordL = ChordLength(x0,y0,z0,x1,y1,z1);
    mclArray(end+1) = chordL;
    x1Array(end + 1) = x1;
    y1Array(end + 1) = y1;
    z1Array(end + 1) = z1;
end
mu = mean(mclArray)
sigma = std(mclArray);

figure(1)
plot3(x1Array,y1Array,z1Array,'.')

figure(2)
a = histogram(mclArray,100)
c = a.Values;
c = max(c);
b = a.BinLimits;
b = mean(b);
grid on;
xlabel('Chord Length', 'FontSize', 15);
ylabel('Frequency', 'FontSize', 15);
xline(mu, 'color', 'g', "LineWidth", 2);
xline(mu - sigma, 'color', 'r', 'LineWidth', 2, 'LineStyle', '--');
xline(mu + sigma, 'color', 'r', 'LineWidth', 2, 'LineStyle', '--');
ylim([0, c * 1.2]); % Give some headroom above the bars.
yl = ylim;
sMean = sprintf('  Mean = %.3f cm \n   SD = %.3f cm \n Analytic = %.3f cm', mu, sigma, analyticalsolution);
text(b, 0.9*yl(2), sMean, 'Color', 'r','FontWeight', 'bold', 'FontSize', 12, 'EdgeColor', 'b');
sMean2= sprintf('Interaction Count vs Depth in Medium. N = %.0f particles  Mean = %.3f. cm  SD = %.3f cm', n, mu, sigma);
title(sMean2, 'FontSize', 15);

end
