<?php

namespace Yandex\Market\Partner\Models;

use Yandex\Market\Partner\Models\Campaigns;
use Yandex\Common\Model;

class GetCampaignsResponse extends Model
{

    protected $campaigns = null;

    protected $mappingClasses = [
        'campaigns' => 'Yandex\Market\Partner\Models\Campaigns'
    ];

    protected $propNameMap = [];

    /**
     * Retrieve the campaigns property
     *
     * @return Campaigns|null
     */
    public function getCampaigns()
    {
        return $this->campaigns;
    }

    /**
     * Set the campaigns property
     *
     * @param Campaigns $campaigns
     * @return $this
     */
    public function setCampaigns($campaigns)
    {
        $this->campaigns = $campaigns;
        return $this;
    }
}
