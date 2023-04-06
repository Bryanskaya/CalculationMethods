function lab01()
    clc();

    debugFlg = 1;
    a = 0;
    b = 1;
    eps = 0.000001;
    
    [xStar, fStar, plotXi, plotFi] = bitwiseSearch(a, b, eps, debugFlg);

    fplot(@f, [a, b]);
    hold on;
    plot(plotXi, plotFi, 'xk');
    hold on;
    scatter(xStar, fStar, 'r', 'filled');
end

function [x0, f0, plotXi, plotFi] = bitwiseSearch(a, b, eps, debugFlg)
    i = 0;
    delta = (b - a) / 4;
    x0 = a;
    f0 = f(x0);

    plotXi = [];
    plotFi = [];

    while 1
        i = i + 1;
        x1 = x0 + delta;
        f1 = f(x1);

        if debugFlg
            fprintf('№ %2d eps=%.7f x*=%.10f f(x*)=%.10f\n', i, eps, x1, f1);
        end

        plotXi(end+1) = x1;
        plotFi(end+1) = f1;

        if f0 > f1
            x0 = x1;
            f0 = f1;

            if a < x0 && x0 < b
                continue
            else
                if abs(delta) <= eps
                    break;
                else
                    x0 = x1;
                    f0 = f1;
                    delta = -delta / 4;
                end
            end
        else
            if abs(delta) <= eps
                break;
            else
                x0 = x1;
                f0 = f1;
                delta = -delta / 4;
            end
        end
    end

    if debugFlg
        fprintf('№ %2d eps=%.7f x*=%.10f f(x*)=%.10f\n', i, eps, x0, f0);
    end
end


function y = f(x)
    y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
end