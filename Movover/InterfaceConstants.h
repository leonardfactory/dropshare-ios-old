//
//  InterfaceConstants.h
//  Movover
//
//  Created by Leonardo Ascione on 12/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#ifndef Shabaka_InterfaceConstants_h
#define Shabaka_InterfaceConstants_h

#pragma mark - Global

#define kDSDefaultDescriptionFontSize 18.0
#define kDSDefaultBigFontSize 16.0
#define kDSDefaultFontSize 14.0
#define kDSDefaultSmallFontSize 12.0
#define kDSDefaultMicroFontSize 11.0
#define kDSDefaultCornerRadius 4.0



#pragma mark - Drop Cell

#define kDSCellCornerRadius kDSDefaultCornerRadius + 2.0

#define kDSCellInnerShadowAlpha 0.5

#define kDSCellWidth 320.0
#define kDSCellHeight (76.0 + 36.0 + 36.0)

#define kDSCellBackgroundMargin 6.0
#define kDSCellBackgroundBottomExtraMargin 4.0

#define kDSCellBackgroundWidth (kDSCellWidth - 2 * kDSCellBackgroundMargin)
#define kDSCellBackgroundHeight (kDSCellHeight - kDSCellBackgroundMargin - kDSCellBackgroundBottomExtraMargin)

#define kDSCellTopMargin 16.0

#define kDSCellLabelLeftMargin 72.0
#define kDSCellLabelWidth 234.0

#define kDSCellNameFontSize kDSDefaultFontSize
//#define kDSCellUsernameWidth kDSCellLabelWidth
#define kDSCellNameHeight (kDSCellNameFontSize + 2)
#define kDSCellNameTopMargin kDSCellTopMargin

#define kDSCellUsernameFontSize kDSDefaultSmallFontSize
//#define kDSCellUsernameWidth kDSCellLabelWidth
#define kDSCellUsernameHeight (kDSCellUsernameFontSize + 2)
#define kDSCellUsernameTopMargin kDSCellTopMargin

#define kDSCellDescriptionFontSize kDSDefaultFontSize
#define kDSCellDescriptionWidth kDSCellLabelWidth
#define kDSCellDescriptionHeight (kDSCellDescriptionFontSize + 2)
#define kDSCellDescriptionTopMargin (kDSCellNameTopMargin + kDSCellNameHeight + 2.0)

#define kDSCellAvatarLeftMargin kDSCellTopMargin
#define kDSCellAvatarTopMargin kDSCellAvatarLeftMargin

#define kDSCellAvatarSize 48.0
#define kDSCellAvatarCornerRadius kDSDefaultCornerRadius
#define kDSCellAvatarShadowSize 2.0

#define kDSCellInfoLabelsLeftMargin (kDSCellLabelLeftMargin - kDSCellBackgroundMargin - 2.0)
#define kDSCellInfoLabelsTopMargin 12.0
#define kDSCellInfoLabelsSpacing 4.0
#define kDSCellInfoLabelsInnerHeight 14.0
#define kDSCellInfoLabelsHeight 36.0

#define kDSCellInfoLabelsIconHeight 18.0
#define kDSCellInfoLabelsIconTopMargin (kDSCellInfoLabelsTopMargin + (kDSCellInfoLabelsInnerHeight - kDSCellInfoLabelsIconHeight) / 2.)

#define kDSCellSocialBarHeight 38.0
#define kDSCellSocialBarSpacing 8.0

#define kDSCellSocialButtonHeight 34.0
#define kDSCellSocialButtonBaseWidth 40.0
#define kDSCellSocialButtonWidth 48.0
#define kDSCellSocialButtonTopMargin ((kDSCellSocialBarHeight - kDSCellSocialButtonHeight) / 2.)
#define kDSCellSocialButtonIconSize 20.0

#pragma mark - Drop Cell with Image

#define kDSCellPictureHeight 292.0
#define kDSCellPictureTopGap 4.0
#define kDSCellPictureTopMargin (kDSCellBackgroundMargin - kDSCellPictureTopGap)
#define kDSCellPictureBottomMargin (2.0 - kDSCellPictureTopGap)
#define kDSCellPictureCornerRadius kDSDefaultCornerRadius

#pragma mark - Add Button and relatives

#define kDSAddButtonShowAnimationTime 0.2
#define kDSAddButtonSize 48.0
#define kDSActionButtonSize 48.0
#define kDSActionButtonMargin 8.0

#define kDSAddButtonPadding 12.0


#pragma mark Action Detail ViewController

#define kDSActionAvatarSize 38.0
#define kDSActionBaseTopMargin 10.0
#define kDSActionBaseLeftMargin 10.0
#define kDSActionBaseSpacing 10.0
#define kDSActionWiderSpacing 16.0
#define kDSActionBaseLeftIndentMargin (kDSActionBaseLeftMargin + kDSActionAvatarSize + kDSActionBaseSpacing)

#endif
