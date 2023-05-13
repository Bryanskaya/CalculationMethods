function lab03()
    clc();

    debugFlg = 1;
    delayS = 0.8;
    a = 0;
    b = 1;
    eps = 1e-6;

    fplot(@f, [a, b]);
    hold on;

    pause(3);
    parabolic_method(a, b, eps, debugFlg, delayS);
end

function parabolic_method(a, b, eps, debugFlg, delayS)
    tau = (sqrt(5)-1) / 2;
    l = b - a;

    x1 = b - tau*l;
    x2 = a + tau*l;
    f1 = f(x1);
    f2 = f(x2);

    fprintf('-------Golden ratio method (looking for initial points x1, x2, x3)-------\n');
    i = 0;
    if debugFlg
        fprintf('№ %2d:\t [a, b] = [%.10f, %.10f], f(a) = %.10f, f(b) = %.10f\n', i, a, b, f(a), f(b));
        line([a b], [f(a) f(b)], 'color', 'b');
        hold on;
    end
    while l > 2*eps
        i = i + 1;
        if debugFlg
            line([a b], [f(a) f(b)], 'color', 'b');
            hold on;
        end
        if f1 <= f2
            b = x2;
            l = b - a;

            new_x = b - tau*l;
            new_f = f(new_x);

            if f1 <= new_f
               x3 = x2;     f3 = f2;
               x2 = x1;     f2 = f1;
               x1 = new_x;  f1 = new_f;
               break;
            end

            x2 = x1;        f2 = f1;
            x1 = new_x;     f1 = new_f;
        else
            a = x1;
            l = b - a;

            new_x = a + tau*l;
            new_f = f(new_x);

            if f2 <= new_f
                x1 = a;
                x3 = new_x; f3 = new_f;
                break;
            end

            x1 = x2;        f1 = f2;
            x2 = new_x;     f2 = new_f;
        end
        if debugFlg
            fprintf('№ %2d:\t [a, b] = [%.10f, %.10f], f(a) = %.10f, f(b) = %.10f\n', i, a, b, f(a), f(b));
            line([a b], [f(a) f(b)], 'color', 'r');
            hold on;
            pause(delayS);
        end
    end

    if debugFlg
        fprintf('Found x1 = %.10f, x2 = %.10f, x3 = %.10f\n', x1, x2, x3);
        scatter(x1, f1, 'green', 'filled');
        scatter(x2, f2, 'green', 'filled');
        scatter(x3, f3, 'green', 'filled');
        line([x1 x3], [f1 f3], 'color', 'b');
        hold on;
        pause(delayS*2);
    end

    if l <= 2*eps
        x_res = (a+b)/2;
        f_res = f(x_res);

        if debugFlg
            scatter(x_res, f_res, 'r', 'filled');
            fprintf('RESULT: %2d iterations, x=%.10f, f(x)=%.10f\n', i, x_res, f_res);
        end

        return;
    end

    fprintf('-------Parabolic method-------\n');

    a1 = (f2 - f1) / (x2 - x1);
    a2 = ((f3 - f1)/(x3 - x1) - (f2 - f1)/(x2 - x1)) / (x3 - x2);
    x_ = 1 / 2 * (x1 + x2 - a1/a2);
    f_ = f(x_);

    for i = 1:1000
        old_x_ = x_;

        if f_ > f2
            temp = f_; f_ = f2; f2 = temp;
            temp = x_; x_ = x2; x2 = temp;
        end

        if x_ > x2
            x1 = x2; f1 = f2;
            x2 = x_; f2 = f_;
        else
            x3 = x2; f3 = f2;
            x2 = x_; f2 = f_;
        end

        if debugFlg
            fprintf('№ %2d:\t [x1, x3] = [%.10f, %.10f], f(x1) = %.10f, f(x3) = %.10f\n', i, x1, x3, f1, f3);
            fprintf('Current min point: x=%.10f, f(x)=%.10f\n', x_, f_);
            line([x1 x3], [f1 f3], 'color', 'b');
            plot(x_, f_, 'xk');
            hold on;
            pause(delayS);
        end

        a1 = (f2 - f1) / (x2 - x1);
        a2 = ((f3 - f1)/(x3 - x1) - (f2 - f1)/(x2 - x1)) / (x3 - x2);
        x_ = 1 / 2 * (x1 + x2 - a1/a2);
        f_ = f(x_);

        if abs(old_x_ - x_) <= eps
            break
        end
    end

    x_res = x_;
    f_res = f_;

    if debugFlg
        scatter(x_res, f_res, 'r', 'filled');
        fprintf('RESULT: %2d iterations, x=%.10f, f(x)=%.10f\n', i, x_res, f_res);
    end

end

function y = f(x)
    %y = cos(power(x,5) - x + 3 + power(2, 1/3)) + atan((power(x,3) - 5 * sqrt(2)*x - 4) / (sqrt(6)*x + sqrt(3))) + 1.8;
    y = (x-0.222).^4;
end