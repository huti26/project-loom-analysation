var scope = new ContinuationScope("ContinuationScope");
var continuation = new Continuation(scope, () -> {
    int n = 0;
    for (int i = 0; i < 6; i++) {
        n = n + i;
        Continuation.yield(scope);
    }

});

while (!continuation.isDone()) {
    continuation.run();
}