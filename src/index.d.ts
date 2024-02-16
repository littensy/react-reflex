import React from "@rbxts/react";
import { InferState, Producer } from "@rbxts/reflex";

export = ReactReflex;
export as namespace ReactReflex;

declare namespace ReactReflex {
	const ReflexContext: React.Context<Producer>;

	interface ReflexProviderProps<State> {
		/**
		 * The root producer to provide to the Reflex context.
		 */
		producer: Producer<State>;
		/**
		 * An optional initial state snapshot to merge into the producer's state.
		 */
		initialState?: Partial<State>;
		/**
		 * The children to render.
		 */
		children?: React.ReactNode;
	}

	function ReflexProvider<State>(props: ReflexProviderProps<State>): React.Element;

	/**
	 * Returns the root producer passed to the `<ReflexProvider>`.
	 *
	 * @example
	 * const useRootProducer: UseProducerHook<RootProducer> = useProducer;
	 *
	 * @returns The root producer passed to the `<ReflexProvider>`.
	 */
	type UseProducerHook<Producer> = () => Producer;

	/**
	 * Returns the root producer passed to the `<ReflexProvider>`.
	 *
	 * @example
	 * const rootProducer = useProducer<RootProducer>();
	 *
	 * @returns The root producer passed to the `<ReflexProvider>`.
	 */
	function useProducer<T = Producer>(): T;

	/**
	 * Returns the result of a selector function applied to the current state.
	 *
	 * @example
	 * const useRootSelector: UseSelectorHook<RootProducer> = useSelector;
	 *
	 * @param selector A function that takes the current state and returns a value
	 * @param equalityFn An optional function that determines whether the
	 * component should re-render
	 * @returns The result of the selector function
	 */
	export type UseSelectorHook<Producer> = <Result>(
		selector: (state: InferState<Producer>) => Result,
		equalityFn?: (next: Result, prev: Result) => boolean,
	) => Result;

	/**
	 * Returns the result of a selector function applied to the current state.
	 *
	 * @example
	 * const selectedValue = useSelector((state: RootState) => state.value);
	 *
	 * @param selector A function that takes the current state and returns a value
	 * @param equalityFn An optional function that determines whether the
	 * component should re-render
	 * @returns The result of the selector function
	 */
	function useSelector<Result>(
		selector: (state: any) => Result,
		equalityFn?: (next: Result, prev: Result) => boolean,
	): Result;

	/**
	 * Similar to `useSelector`, but accepts a selector factory that returns a
	 * selector. The selector factory is only called when the arguments change,
	 * and the selector is memoized.
	 *
	 * @example
	 * const useRootSelectorCreator: UseSelectorCreatorHook<RootProducer> = useSelectorCreator;
	 *
	 * @param selectorFactory A function that returns a selector
	 * @param args Arguments to pass to the selector factory
	 * @returns The result of the selector function
	 */
	export type UseSelectorCreatorHook<Producer> = <Result, Args extends any[]>(
		selectorFactory: (...args: Args) => (state: InferState<Producer>) => Result,
		...args: Args
	) => Result;

	/**
	 * Similar to `useSelector`, but accepts a selector factory that returns a
	 * selector. The selector factory is only called when the arguments change,
	 * and the selector is memoized.
	 *
	 * @example
	 * const selectById = (id: string) => (state: RootState) => state[id];
	 * const result = useSelectorCreator(selectById, "hello-world");
	 *
	 * @param selectorFactory A function that returns a selector
	 * @param args Arguments to pass to the selector factory
	 * @returns The result of the selector function
	 */
	function useSelectorCreator<Result, Args extends any[]>(
		selectorFactory: (...args: Args) => (state: any) => Result,
		...args: Args
	): Result;
}
