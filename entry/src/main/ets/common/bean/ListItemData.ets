/**
 * Basic list item data bean.
 */
export class ListItemData {
  /**
   * Indicates list item title.
   */
  title: Resource;

  /**
   * Indicates list item summary.
   */
  summary: Resource;
}

export class TabItemData {
  /**
   * Original image of the tabs.
   */
  imageOriginal: string;

  /**
   * Active image of the tabs.This image is displayed when you click the tab.
   */
  imageActivated: string;

  /**
   * Tab title.
   */
  title: string;
}

export enum HomePageName {
  home = 0,
  add = 1,
  mine = 2,
}

@Observed
export class UserInfo {
  id: number;
  phone_number: string;
  nick_name: string;
  sex: number;
  birth_date: string;
  intro: string;
  avatar: string;
}

@Observed
export class Pet {
  id: number;
  nick_name: string;
  sex: number;
  birth_date: number;
  intro: string;
  avatar: string;
}
