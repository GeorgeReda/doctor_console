class ServerException implements Exception {}

/// The code provided by the user is either used before
/// or it's not in the db.
class CodeInvalidException implements Exception {}

/// The password provided by the user is incorrect.
class PasswordInvalidException implements Exception {}

/// The email provided by the user is incorrect.
class EmailInvalidException implements Exception {}

///  The code provided by the user is already used.
class AlreadyUsedCodeException implements Exception {}

/// There's no cached user.
class NoCachedDataException implements Exception {}

/// The device used is not safe
class NotSafeException implements Exception {}

/// The Exam was submitted before
class ExamAlreadySubmittedException implements Exception {}
