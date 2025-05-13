#include <benchmark/benchmark.h>

#include "lib/greeter/include/greeter.h"

static const greeter::Greeter greetr("Tests");

static void BM_greeter(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(greetr.greet(greeter::LanguageCode::EN));
  }
}

// Register the function as a benchmark
BENCHMARK(BM_greeter);
// Run the benchmark
BENCHMARK_MAIN();
