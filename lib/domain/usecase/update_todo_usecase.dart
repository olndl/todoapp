abstract class UpdateTodoUseCase {
  Future<void> execute(
      final int revision,
      final String id,
      final int createdAt,
      final String title,
      final String lastUpdatedBy,
      final int changedAt,
      final int? dueDate,
      final String? color,
      final bool isCompleted,
      final String importance,
  );
}
