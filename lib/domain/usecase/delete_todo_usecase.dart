abstract class DeleteTodoUseCase {
  Future<void> execute(final String id, final int revision);
}
