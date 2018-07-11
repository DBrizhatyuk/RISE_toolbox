classdef mcmc < handle
% mcmc object makes diagnostic plots from mcmc draws
%

    properties
        pnames
        nchains
        npop
        nparams
        draws
        i_dropped
        start
        psrf
        best
    end

    methods

        function obj=mcmc(draws,pnames,drop,start_from,trimming)

            if nargin<5

                trimming=[];

                if nargin<4

                    start_from=[];

                    if nargin<3

                        drop=[];

                        if nargin<2

                            pnames=[];

                            if nargin<1

                                obj=mcmc.empty();

                                return

                            end

                        end

                    end

                end

            end

            [obj.draws,obj.i_dropped,obj.start,results_summary]=mcmc.process_draws(draws,drop,start_from,trimming);

            obj.best=results_summary.best_of_the_best;

            [obj.nchains,obj.npop]=size(obj.draws);

            if obj.npop

                obj.nparams=numel(obj.draws(1).x);

            else

                obj=mcmc.empty();

                return

            end

            if isempty(pnames)

                pnames=parser.create_state_list('p',obj.nparams);

            end

            obj.pnames=pnames;

            if obj.npop

                obj.psrf=gelman_rubin(obj,true);

            end

        end

        varargout=traceplot(varargin)

        varargout=densplot(varargin)

        varargout=meanplot(varargin)

        varargout=autocorrplot(varargin)

        varargout=gelman_plot(varargin)

        varargout=scatterplot(varargin)

        varargout=summary(varargin)

        varargout=heidelberg_welch(varargin)

    end

    methods(Static)

        varargout=process_draws(varargin)

    end

    methods(Access=private)

        varargout=load_draws(varargin)

        varargout=gelman_rubin(varargin)

    end

end