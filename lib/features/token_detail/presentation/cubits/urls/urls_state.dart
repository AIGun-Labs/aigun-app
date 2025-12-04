part of 'urls_cubit.dart';

@freezed
class UrlsState with _$UrlsState {
  const factory UrlsState.initial() = _Initial;
  const factory UrlsState.loading() = _Loading;
  const factory UrlsState.success(UrlsEntity urls) = _Success;
  const factory UrlsState.error(String message) = _Error;
}
