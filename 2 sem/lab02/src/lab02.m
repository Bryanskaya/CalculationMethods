function lab02()
    clc();

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-6;

    fplot(@f, [a, b]);
    hold on;

    pause(3);
    [xStar, fStar] = goldenRatio(a, b, eps, debugFlg, delayS);

    scatter(xStar, fStar, 'r', 'filled');
end

function [xStar, fStar] = goldenRatio(a, b, eps, debugFlg, delayS)
    tau = (sqrt(5) - 1) / 2;
    l = b - a;

    x1 = b - tau * l;
    x2 = a + tau * l;
    f1 = f(x1);
    f2 = f(x2);

    i = 0;
    while 1
        i = i + 1;

        if debugFlg
            fprintf('№ %2d ai=%.10f bi=%.10f\n', i, a, b);
            line([a b], [f(a) f(b)], 'color', 'b');
            %plot(a, f(a), 'xm', b, f(b), 'xb');
            hold on;
            pause(delayS);
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
        else
            xStar = (a + b) / 2;
            fStar= f(xStar);
            break
        end
    end

    i = i + 1;
    if debugFlg
        fprintf('№ %2d ai=%.10f bi=%.10f\n', i, a, b);
        fprintf('RESULT: x*=%.10f f(x*)=%.10f\n', xStar, fStar);

        line([a b], [f(a) f(b)], 'color', 'r');
    end
end

function y = f(x)
    %y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
    y = (x - 0.50)^4;
end