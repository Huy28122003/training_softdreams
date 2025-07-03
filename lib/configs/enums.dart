/// Represents the authentication status of a user
enum AuthStatus {
  // Initial state, authentication status unknown
  initial,

  // User is currently being authenticated
  authenticating,

  // User is successfully authenticated
  authenticated,

  // User is not authenticated
  unauthenticated,
}

/// Represents different types of loading states
enum LoadingStatus {
  // Initial state before any loading begins
  initial,

  // Currently loading/in progress
  loading,

  // Loading completed successfully
  success,

  // Loading failed with an error
  failure,
}

/// Represents different types of network connection states
enum ConnectionStatus {
  // Connected to the internet
  connected,

  // Not connected to the internet
  disconnected,

  // Connection status unknown
  unknown,
}

/// Represents different types of image selection actions
enum SelectImageAction {
  // Select image from camera
  camera,

  // Select image from gallery
  gallery,

  // Delete selected image
  delete,
}

/// Represents different types of transaction statuses
enum TransactionStatus {
  // Undefined status
  undefined,

  // Transaction successful
  success,

  // Transaction failed
  failure,
}
