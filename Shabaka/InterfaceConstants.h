//
//  InterfaceConstants.h
//  Shabaka
//
//  Created by Leonardo Ascione on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#ifndef Shabaka_InterfaceConstants_h
#define Shabaka_InterfaceConstants_h

#pragma mark - Global

#define kDSDefaultFontSize 14.0
#define kDSDefaultSmallFontSize 12.0
#define kDSDefaultCornerRadius 4.0



#pragma mark - Drop Cell

#define kDSCellInnerShadowAlpha 0.5

#define kDSCellWidth 320.0
#define kDSCellHeight 86.0

#define kDSCellBackgroundMargin 6.0
#define kDSCellBackgroundBottomExtraMargin 0.0

#define kDSCellBackgroundWidth (kDSCellWidth - 2 * kDSCellBackgroundMargin)
#define kDSCellBackgroundHeight (kDSCellHeight - kDSCellBackgroundMargin - kDSCellBackgroundBottomExtraMargin)

#define kDSCellTopMargin 16.0

#define kDSCellLabelLeftMargin 72.0
#define kDSCellLabelWidth 234.0

#define kDSCellUsernameFontSize kDSDefaultFontSize
#define kDSCellUsernameWidth kDSCellLabelWidth
#define kDSCellUsernameHeight (kDSCellUsernameFontSize + 2)
#define kDSCellUsernameTopMargin kDSCellTopMargin

#define kDSCellDescriptionFontSize kDSDefaultFontSize
#define kDSCellDescriptionWidth kDSCellLabelWidth
#define kDSCellDescriptionHeight (kDSCellDescriptionFontSize + 2)
#define kDSCellDescriptionTopMargin (kDSCellUsernameTopMargin + kDSCellUsernameHeight)

#define kDSCellAvatarLeftMargin kDSCellTopMargin
#define kDSCellAvatarTopMargin kDSCellAvatarLeftMargin

#define kDSCellAvatarSize 48.0
#define kDSCellAvatarCornerRadius kDSDefaultCornerRadius
#define kDSCellAvatarShadowSize 2.0

#define kDSCellInfoLabelsTopMargin 12.0


#pragma mark - Drop Cell with Image

#define kDSCellPictureHeight 292.0
#define kDSCellPictureTopMargin 12.0
#define kDSCellPictureBottomMargin 6.0
#define kDSCellPictureCornerRadius kDSDefaultCornerRadius

#endif
