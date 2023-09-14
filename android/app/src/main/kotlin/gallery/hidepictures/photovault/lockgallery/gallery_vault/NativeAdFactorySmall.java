//package gallery.hidepictures.photovault.lockgallery.gallery_vault;
//
//import android.content.Context;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.widget.Button;
//import android.widget.ImageView;
//import android.widget.RatingBar;
//import android.widget.TextView;
//
//import com.google.android.gms.ads.nativead.NativeAd;
//import com.google.android.gms.ads.nativead.NativeAdView;
//
//import java.util.Map;
//
//import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
//
//class NativeAdFactorySmall implements GoogleMobileAdsPlugin.NativeAdFactory {
//
//    private final Context context;
//
//    NativeAdFactorySmall(Context context) {
//        this.context = context;
//    }
//
//
//    public NativeAdView createNativeAd(
//            NativeAd nativeAd, Map<String, Object> customOptions) {
//        NativeAdView nativeAdView = (NativeAdView) LayoutInflater.from(context)
//                .inflate(R.layout.ads_big_native_admob, null);
//
//
//
////    attribution
//
//        TextView attributionViewSmall = nativeAdView
//                .findViewById(R.id.native_ad_attribution_small);
//
//
//        attributionViewSmall.setVisibility(View.VISIBLE);
//// icon
//
//        nativeAdView.setIconView(nativeAdView.findViewById(R.id.ad_app_icon));
//        if (nativeAd.getIcon() == null) {
//            nativeAdView.getIconView().setVisibility(View.GONE);
//
//        } else {
//            ((ImageView)nativeAdView.getIconView()).setImageDrawable(nativeAd.getIcon().getDrawable());
//
//        }
//
////  media
////        MediaView mediaView = nativeAdView.findViewById(R.id.native_ad_media);
////        mediaView.setMediaContent(nativeAd.getMediaContent());
////        nativeAdView.setMediaView(mediaView);
//
//// mediaview
//
//        nativeAdView.setMediaView(nativeAdView.findViewById(R.id.ad_media));
//        if(nativeAd.getMediaContent()==null){
//            nativeAdView.getMediaView().setVisibility(View.INVISIBLE);
//        }else{
//            (nativeAdView.getMediaView()).setMediaContent(nativeAd.getMediaContent());
//        }
//// button
//
//        nativeAdView.setCallToActionView(nativeAdView.findViewById(R.id.ad_call_to_action));
//        if(nativeAd.getCallToAction()==null){
//            nativeAdView.getCallToActionView().setVisibility(View.INVISIBLE);
//        }else{
//            ((Button)nativeAdView.getCallToActionView()).setText(nativeAd.getCallToAction());
//        }
//
////   headline
//        nativeAdView.setHeadlineView(nativeAdView.findViewById(R.id.ad_headline));
//        ((TextView)nativeAdView.getHeadlineView()).setText(nativeAd.getHeadline());
//
////  bodyView
//        nativeAdView.setBodyView(nativeAdView.findViewById(R.id.ad_body));
//        if(nativeAd.getBody()==null){
//            nativeAdView.getBodyView().setVisibility(View.INVISIBLE);
//        }else {
//            ((TextView)nativeAdView.getBodyView()).setText(nativeAd.getBody());
//            nativeAdView.getBodyView().setVisibility(View.VISIBLE);
//        }
//
////    advertiser name
//        nativeAdView.setAdvertiserView(nativeAdView.findViewById(R.id.ad_advertiser));
//        if(nativeAd.getAdvertiser()==null){
//            nativeAdView.getAdvertiserView().setVisibility(View.GONE);
//        }else {
//            ((TextView)nativeAdView.getAdvertiserView()).setText(nativeAd.getAdvertiser());
//            nativeAdView.getAdvertiserView().setVisibility(View.VISIBLE);
//        }
////   ratingbar
//        nativeAdView.setStarRatingView(nativeAdView.findViewById(R.id.ad_stars));
//        if(nativeAd.getStarRating()==null){
//            nativeAdView.getStarRatingView().setVisibility(View.INVISIBLE);
//        }else{
//            ((RatingBar)nativeAdView.getStarRatingView()).setRating(nativeAd.getStarRating().floatValue());
//            nativeAdView.getStarRatingView().setVisibility(View.VISIBLE);
//
//        }
//        //   adprice
//        nativeAdView.setPriceView(nativeAdView.findViewById(R.id.ad_price));
//        if(nativeAd.getPrice()==null){
//            nativeAdView.getPriceView().setVisibility(View.INVISIBLE);
//        }else{
//            ((RatingBar)nativeAdView.getStarRatingView()).setRating(nativeAd.getStarRating().floatValue());
//            nativeAdView.getPriceView().setVisibility(View.VISIBLE);
//
//        }
//        //   ad_store
//        nativeAdView.setStoreView(nativeAdView.findViewById(R.id.ad_store));
//        if(nativeAd.getStore()==null){
//            nativeAdView.getStoreView().setVisibility(View.INVISIBLE);
//        }else{
//            ((RatingBar)nativeAdView.getStarRatingView()).setRating(nativeAd.getStarRating().floatValue());
//            nativeAdView.getStoreView().setVisibility(View.VISIBLE);
//
//        }
//
//
//
//
//        nativeAdView.setNativeAd(nativeAd);
//
//        return nativeAdView;
//    }
//}
