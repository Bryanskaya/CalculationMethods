function lab04()
    clc();

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-6;
    h = 1e-3;

    fplot(@f, [a, b]);
    hold on;

    pause(3);
    modified_newton_method(a, b, eps, h, debugFlg, delayS);

    if debugFlg
        [x_res, f_res, temp] = fminbnd(@f, a, b);
        fprintf('fminbnd: x=%.10f, f(x)=%.10f\n', x_res, f_res);
        %scatter(x_res, f_res, 's', 'filled');
    end
end

function modified_newton_method(a, b, h, eps, debugFlg, delayS)
    x = (a + b) / 2;

    i = 1;
    while 1
        f_inc = f(x + h);
        f_dec = f(x - h);
        f_x = f(x);

        f1 = (f_inc - f_dec) / (2 * h);

        if debugFlg
            fprintf("№ %2d:\t x = %.10f, f(x) = %.10f, f\'(x) = %.10f \n", i, x, f_x, f1);
            plot(x, f_x, 'xk');
            hold on;
            pause(delayS);
        end

        f2 = (f_inc - 2 * f_x + f_dec) / (h^2);
        x_temp = x;
        x = x_temp - f1 / f2;

        if abs(x - x_temp) < eps
            break;
        end

        i = i + 1;
    end

    x_star = x;
    f_star = f_x;

    if debugFlg
        fprintf('RESULT: %2d iterations: x=%.10f, f(x)=%.10f\n', i, x_star, f_star);
        scatter(x_star, f_star, 'r', 'filled');
    end
end

function y = f(x)
    %y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
    %y = (x - 0.111)^4;
    y = sinh((3 * x.^4 - x + sqrt(17) - 3) / 2) + sin((5.^ 1/3 * x.^3 - 5.^1/3 * x + 1 - 2 * 5.^1/3) / (-x.^3 + x + 2));
end