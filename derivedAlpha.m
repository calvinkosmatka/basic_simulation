function alphaFunc = derivedAlpha(method)
    x = sym('x');
    function an = aveAlph(t)
        s = vpasolve(0 == .5*(6*x - 3*t*(1 - x^2))*exp((1-x)*t) - x, x);
        an = -log(((3*exp(-s*t))-((s^2)*exp(-t)))/(3*(1-s^2)));
    end
    %could be added to to accommodate new inference methods if needed
    if isequal(method, @inferenceMin6)
        alphaFunc = @(x) x ;
    elseif isequal(method, @inferenceMajority6)
        alphaFunc = @(x) -log(2*sqrt((1/3)*exp(-x)*(1-(2/3)*exp(-x))) + (1/3)*exp(-x));
    elseif isequal(method, @inferenceAverage6)
        %for small x
        %will eventually incorporate finding the solution to the fixed
        %point equation
        %alphaFunc = @(x) (3/8)*x^2;
        alphaFunc = @aveAlph;
        % -log(solve(
    end
end