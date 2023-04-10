function lab02()
    clc();

    debugFlg = 1;
    a = 0;
    b = 1;
    eps = 0.000001;

    [xStar, fStar, plot_ax, plot_ay, plot_bx, plot_by] = goldenRatio(a, b, eps, debugFlg);

    fplot(@f, [a, b]);
    hold on;
    if debugFlg
        plot(plot_ax, plot_ay, 'xk', plot_bx, plot_by, 'xb');
        hold on;
    end
    scatter(xStar, fStar, 'r', 'filled');
end

function [xStar, fStar, plot_ax, plot_ay, plot_bx, plot_by] = goldenRatio(a, b, eps, debugFlg)
    tau = (sqrt(5) - 1) / 2;
    l = b - a;

    x1 = b - tau * l;
    x2 = a + tau * l;
    f1 = f(x1);
    f2 = f(x2);

    plot_ax = [];
    plot_ay = [];
    plot_bx = [];
    plot_by = [];

    i = 0;
    while 1
        i = i + 1;

        if debugFlg
            fprintf('№ %2d x*=%.10f f(x*)=%.10f ai=%.5f bi=%.5f\n', i, x1, f1, a, b);
        end

        if l > 2 * eps
            if f1 <= f2
                b = x2;
                l = b - a;
                x2 = x1;
                f2 = f1;
                x1 = b - tau * l;
                f1 = f(x1);
            else
                a = x1;
                l = b - a;
                x1 = x2;
                f1 = f2;
                x2 = a + tau * l;
                f2 = f(x2);
            end

            plot_ax(end+1) = a;
            plot_ay(end+1) = f(a);
            plot_bx(end+1) = b;
            plot_by(end+1) = f(b);
        else
            xStar = (a + b) / 2;
            fStar= f(xStar);
            break
        end

    end

    if debugFlg
        fprintf('№ %2d x*=%.10f f(x*)=%.10f ai=%.5f bi=%.5f\n', i, xStar, fStar, a, b);
    end
end

function y = f(x)
    y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
end