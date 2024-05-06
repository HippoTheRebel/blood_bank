class BloodDataState {
  final bool donorLoading;
  final bool transfustionLoading;
  final bool bloodRequestLoading;
  final bool bloodIssueLoading;
  BloodDataState({
    required this.donorLoading,
    required this.transfustionLoading,
    required this.bloodRequestLoading,
    required this.bloodIssueLoading,
  });

  BloodDataState copyWith({
    bool? donorLoading,
    bool? transfustionLoading,
    bool? bloodRequestLoading,
    bool? bloodIssueLoading,
  }) {
    return BloodDataState(
      donorLoading: donorLoading ?? this.donorLoading,
      transfustionLoading: transfustionLoading ?? this.transfustionLoading,
      bloodRequestLoading: bloodRequestLoading ?? this.bloodRequestLoading,
      bloodIssueLoading: bloodIssueLoading ?? this.bloodIssueLoading,
    );
  }
}
